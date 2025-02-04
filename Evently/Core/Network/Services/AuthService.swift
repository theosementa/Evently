//
//  AuthService.swift
//  Evently
//
//  Created by Theo Sementa on 04/02/2025.
//

import Foundation

struct AuthService {

    static func stepTwo(body: StepTwoBody) async throws -> AuthResponse {
        return try await NetworkService.shared.sendRequest(
            apiBuilder: AuthAPIRequester.stepTwo(body: body),
            responseModel: AuthResponse.self
        )
    }

}
