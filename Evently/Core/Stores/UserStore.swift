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
    var friends: [UserModel] = []
}

extension UserStore {

    @MainActor
    func loginWithToken() async throws {
        try await TokenManager.shared.refreshToken()
    }

    @MainActor
    func login() async {
        guard let refreshToken = KeychainService.retrieveItemFromKeychain(id: "refreshToken", type: String.self),
              !refreshToken.isEmpty else {
            UserStore.shared.currentUser = nil
            return
        }

        do {
            try await loginWithToken()

#if DEBUG
            print("⚒️ TOKEN : \(TokenManager.shared.token)")
            print("⚒️ Refresh Token :\(KeychainService.retrieveItemFromKeychain(id: "refreshToken", type: String.self))")
#endif

        } catch {
            NetworkService.handleError(error: error)
            self.currentUser = nil
        }
    }

    @MainActor
    func fetchFriends() async {
        do {
            let friends = try await UserService.fetchFriends()
            self.friends = friends
        } catch { NetworkService.handleError(error: error) }
    }

}
