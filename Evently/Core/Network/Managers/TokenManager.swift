//
//  TokenManager.swift
//  HappyEat_iOS
//
//  Created by Theo Sementa on 12/03/2024.
//

import Foundation
import KeychainKit

class TokenManager: ObservableObject {
    static let shared = TokenManager()

    @Published var token: String = ""
}

extension TokenManager {

    func setToken(token: String) {
        self.token = token
    }

    func setTokenAndRefreshToken(token: String, refreshToken: String) {
        self.token = token
        KeychainService.setItemToKeychain(id: "refreshToken", data: refreshToken, accessGroup: AppConstant.appGroupForKeychain)
    }

    @MainActor
    func refreshToken() async throws {
        if let refreshTokenInKeychain = KeychainService.retrieveItemFromKeychain(id: "refreshToken", type: String.self, accessGroup: AppConstant.appGroupForKeychain),
           !refreshTokenInKeychain.isEmpty {
            do {
                let user = try await NetworkService.shared.sendRequest(
                    apiBuilder: UserAPIRequester.refreshToken(refreshToken: refreshTokenInKeychain),
                    responseModel: UserModel.self
                )

                if let refreshToken = user.refreshToken, let token = user.token {
                    setTokenAndRefreshToken(token: token, refreshToken: refreshToken)
                    UserStore.shared.currentUser = user
                } else {
                    throw NetworkError.refreshTokenFailed
                }
            }
        } else {
            UserStore.shared.currentUser = nil
            TokenManager.shared.setTokenAndRefreshToken(token: "", refreshToken: "")
            throw NetworkError.refreshTokenFailed
        }
    }

}
