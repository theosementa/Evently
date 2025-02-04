//
//  SignInWithAppleManager.swift
//  Split
//
//  Created by KaayZenn on 29/05/2024.
//

import Foundation
import AuthenticationServices
import NavigationKit

class SignInWithAppleManager: NSObject {

    var router: Router<NavigationDestination>

    init(router: Router<NavigationDestination>) {
        self.router = router
    }

    func performSignIn() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]

        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
}

extension SignInWithAppleManager: ASAuthorizationControllerDelegate,
                                  ASAuthorizationControllerPresentationContextProviding {

    func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithAuthorization authorization: ASAuthorization
    ) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {

            guard let appleIDToken = appleIDCredential.identityToken else { return }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else { return }

            Task {
                let authResponse = try await NetworkService.shared.sendRequest(
                    apiBuilder: AuthAPIRequester.apple(body: .init(identityToken: idTokenString)),
                    responseModel: AuthResponse.self
                )

                if let needStepTwo = authResponse.needStepTwo, needStepTwo,
                   let finalUser = authResponse.user, let token = finalUser.token {
                    let viewModel: LoginViewModel = .shared

                    if let fullName = appleIDCredential.fullName {
                        viewModel.firstName = fullName.givenName ?? ""
                        viewModel.lastName = fullName.familyName ?? ""
                    }

                    TokenManager.shared.setToken(token: token)

                    await MainActor.run {
                        router.pushStepTwo()
                    }
                } else {
                    if let finalUser = authResponse.user,
                       let token = finalUser.token,
                       let refreshToken = finalUser.refreshToken {
                        TokenManager.shared.setTokenAndRefreshToken(token: token, refreshToken: refreshToken)
                        UserStore.shared.currentUser = finalUser
                        AppManager.shared.appState = .running
                    }
                }
            }
        }
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Sign in with Apple errored: \(error.localizedDescription)")
    }

    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first ?? UIWindow()
    }
}
