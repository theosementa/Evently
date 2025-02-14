//
//  UserService.swift
//  Evently
//
//  Created by Theo Sementa on 02/02/2025.
//

import Foundation

struct UserService {

    static func register(body: UserModel) async throws -> UserModel {
        return try await NetworkService.shared.sendRequest(
            apiBuilder: UserAPIRequester.register(body: body),
            responseModel: UserModel.self
        )
    }

    static func login(email: String, password: String) async throws -> UserModel {
        return try await NetworkService.shared.sendRequest(
            apiBuilder: UserAPIRequester.login(email: email, pasword: password),
            responseModel: UserModel.self
        )
    }

    static func update(body: UserModel) async throws -> UserModel {
        return try await NetworkService.shared.sendRequest(
            apiBuilder: UserAPIRequester.update(body: body),
            responseModel: UserModel.self
        )
    }

    static func delete() async throws {
        try await NetworkService.shared.sendRequest(
            apiBuilder: UserAPIRequester.delete
        )
    }

    static func fetchFriends() async throws -> [UserModel] {
        return try await NetworkService.shared.sendRequest(
            apiBuilder: UserAPIRequester.fetchFriends,
            responseModel: [UserModel].self
        )
    }

    static func isEmailAvailable(_ email: String) async throws -> EmailAvailability {
        return try await NetworkService.shared.sendRequest(
            apiBuilder: UserAPIRequester.isEmailAvailable(email: email),
            responseModel: EmailAvailability.self
        )
    }

}
