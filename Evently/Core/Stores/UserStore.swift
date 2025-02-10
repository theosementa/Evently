//
//  UserStore.swift
//  Evently
//
//  Created by Theo Sementa on 02/02/2025.
//

import Foundation
import KeychainKit

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
        guard let refreshToken = KeychainService.retrieveItemFromKeychain(id: "refreshToken", type: String.self, accessGroup: AppConstant.appGroupForKeychain),
              !refreshToken.isEmpty else {
            UserStore.shared.currentUser = nil
            return
        }

        do {
            try await loginWithToken()

#if DEBUG
            print("⚒️ TOKEN : \(TokenManager.shared.token)")
            print("⚒️ Refresh Token :\(KeychainService.retrieveItemFromKeychain(id: "refreshToken", type: String.self, accessGroup: AppConstant.appGroupForKeychain))")
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
    func register(email: String, password: String) async {
        do {
            let user = try await UserService.register(body: .init(email: email, password: password))
            self.currentUser = user
        } catch {
            NetworkService.handleError(error: error)
            self.currentUser = nil
        }
    }

}
