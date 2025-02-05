//
//  LoginViewModel.swift
//  Evently
//
//  Created by Theo Sementa on 04/02/2025.
//

import Foundation

@Observable
final class LoginViewModel {
    static let shared = LoginViewModel()

    var firstName: String = ""
    var lastName: String = ""
}

extension LoginViewModel {

    @MainActor
    func stepTwo() async {
        do {
            let authReponse = try await AuthService.stepTwo(
                body: .init(firstname: firstName, lastname: lastName)
            )

            if let finalUser = authReponse.user,
               let token = finalUser.token,
               let refreshToken = finalUser.refreshToken {
                TokenManager.shared.setTokenAndRefreshToken(token: token, refreshToken: refreshToken)
                UserStore.shared.currentUser = finalUser
                AppManager.shared.appState = .running
            }
        } catch { NetworkService.handleError(error: error) }
    }

}
