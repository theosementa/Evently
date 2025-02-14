//
//  UserStore.swift
//  Evently
//
//  Created by Theo Sementa on 02/02/2025.
//

import Foundation

@Observable
final class UserStore {
    static let shared = UserStore()

    var currentUser: UserModel?
}

extension UserStore {

    @MainActor
    func loginWithToken() async throws {
        try await TokenManager.shared.refreshToken()
    }

    @MainActor
    func loginWithTokenWithoutThrow() async {
        do {
            try await TokenManager.shared.refreshToken()
        } catch { NetworkService.handleError(error: error) }
    }

    @MainActor
    func login() async {
        guard let refreshToken = KeychainService.retrieveItemFromKeychain(
            id: KeychainKeys.refreshToken.rawValue,
            type: String.self,
            accessGroup: AppConstant.accessGroupKeychain
        ), !refreshToken.isEmpty else {
            UserStore.shared.currentUser = nil
            return
        }

        do {
            try await loginWithToken()

#if DEBUG
            print("⚒️ TOKEN : \(TokenManager.shared.token)")
            print("⚒️ Refresh Token :\(KeychainService.retrieveItemFromKeychain(id: KeychainKeys.refreshToken.rawValue, type: String.self, accessGroup: AppConstant.accessGroupKeychain))")
#endif

        } catch {
            NetworkService.handleError(error: error)
            self.currentUser = nil
        }
    }

    @MainActor
    func loginWithCredentials(email: String, password: String) async {
        do {
            let user = try await UserService.login(email: email, password: password)
            self.currentUser = user
        } catch {
            NetworkService.handleError(error: error)
            self.currentUser = nil
        }
    }

    @MainActor
    func register(firstName: String, lastName: String, email: String, password: String) async -> UserModel? {
        do {
            let user = try await UserService.register(body: .init(
                firstName: firstName,
                lastName: lastName,
                email: email,
                password: password
            ))
            self.currentUser = user
            if let token = user.token, let refreshToken = user.refreshToken {
                TokenManager.shared.setTokenAndRefreshToken(token: token, refreshToken: refreshToken)
            }
            return user
        } catch {
            NetworkService.handleError(error: error)
            self.currentUser = nil
            return nil
        }
    }

    @MainActor
    func isEmailAvailable(_ email: String) async -> Bool {
        do {
            return try await UserService.isEmailAvailable(email).available ?? false
        } catch {
            NetworkService.handleError(error: error)
            return false
        }
    }

}

extension UserStore {
    
    @MainActor
    func logout() async {
        TokenManager.shared.setTokenAndRefreshToken(token: "", refreshToken: "")
        AppManager.shared.appState = .needToLogin
    }
    
    @MainActor
    func deleteMyAccount() async {
        do {
            try await UserService.delete()
            TokenManager.shared.setTokenAndRefreshToken(token: "", refreshToken: "")
            AppManager.shared.appState = .needToLogin
        } catch {
            NetworkService.handleError(error: error)
        }
    }
    
}
