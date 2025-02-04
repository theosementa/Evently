//
//  SignInWithGoogleManager.swift
//  Split
//
//  Created by KaayZenn on 29/05/2024.
//

// https://paulallies.medium.com/google-sign-in-swiftui-2909e01ea4ed
// https://github.com/google/GoogleSignIn-iOS/issues/378
import SwiftUI
import GoogleSignIn
import NavigationKit

class SignInWithGoogleManager: ObservableObject {

    @Published var givenName: String = ""
    @Published var familyName: String = ""
    @Published var isLoggedIn: Bool = false
    @Published var errorMessage: String = ""

    var router: Router<NavigationDestination>

    init(router: Router<NavigationDestination>) {
        self.router = router
    }

}

extension SignInWithGoogleManager {

    func getUserInfo() async {
        if GIDSignIn.sharedInstance.currentUser != nil {
            let user = GIDSignIn.sharedInstance.currentUser
            guard let user else { return }

            let givenName = user.profile?.givenName
            let familyName = user.profile?.familyName

            self.givenName = givenName ?? ""
            self.familyName = familyName ?? ""
            self.isLoggedIn = true
        } else {
            self.isLoggedIn = false
        }
    }

    @MainActor
    func signIn() {
        guard let presentingViewController = (
            UIApplication.shared.connectedScenes.first as? UIWindowScene
        )?.keyWindow?.rootViewController else { return }

        GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController) { user, error in
            if let error {
                self.errorMessage = "Google Error: \(error.localizedDescription)"
                return
            }

            guard let user else { return }
            guard let googleToken = user.user.idToken else { return }

            Task {
                await self.getUserInfo()

                let authResponse = try await NetworkService.shared.sendRequest(
                    apiBuilder: AuthAPIRequester.google(body: .init(identityToken: googleToken.tokenString)),
                    responseModel: AuthResponse.self
                )

                // If user need step two
                if let stepTwo = authResponse.needStepTwo, stepTwo,
                   let finalUser = authResponse.user, let token = finalUser.token {
                    let viewModel: LoginViewModel = .shared

                    viewModel.firstName = self.givenName
                    viewModel.lastName = self.familyName

                    TokenManager.shared.setToken(token: token)

                    await MainActor.run {
                        self.router.pushStepTwo()
                    }
                } else {
                    if let finalUser = authResponse.user,
                       let token = finalUser.token,
                       let refreshToken = finalUser.refreshToken {
                        TokenManager.shared.setTokenAndRefreshToken(token: token, refreshToken: refreshToken)
                        AppManager.shared.appState = .running
                        UserStore.shared.currentUser = finalUser
                    }
                }
            }
        }
    } // End SignIn

    func signOut() {
        GIDSignIn.sharedInstance.signOut()
        Task {
            await self.getUserInfo() // Pourquoi faire ?
        }
    }

}
