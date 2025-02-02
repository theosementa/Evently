//
//  UserService.swift
//  Evently
//
//  Created by Theo Sementa on 02/02/2025.
//

import Foundation

struct UserService {
    
    static func register(body: UserRegisterBody) async throws -> UserLoginResponse {
        return try await NetworkService.shared.sendRequest(
            apiBuilder: AuthAPIRequester.register(body: body),
            responseModel: UserLoginResponse.self
        )
    }
    
    static func login(email: String, password: String) async throws -> UserLoginResponse {
        return try await NetworkService.shared.sendRequest(
            apiBuilder: AuthAPIRequester.login(email: email, pasword: password),
            responseModel: UserLoginResponse.self
        )
    }
    
}
