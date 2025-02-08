//
//  FriendService.swift
//  Evently
//
//  Created by Theo Sementa on 07/02/2025.
//

import Foundation

struct FriendService {

    static func fetchAll() async throws -> [UserModel] {
        return try await NetworkService.shared.sendRequest(
            apiBuilder: UserAPIRequester.fetchFriends,
            responseModel: [UserModel].self
        )
    }

    static func fetchAllRequests() async throws -> [FriendRequestModel] {
        return try await NetworkService.shared.sendRequest(
            apiBuilder: FriendAPIRequester.pendingRequests,
            responseModel: [FriendRequestModel].self
        )
    }

    static func fetchAllRequestsSent() async throws -> [FriendRequestModel] {
        return try await NetworkService.shared.sendRequest(
            apiBuilder: FriendAPIRequester.getSentRequests,
            responseModel: [FriendRequestModel].self
        )
    }

    static func sendRequest(to username: String) async throws -> FriendRequestModel {
        return try await NetworkService.shared.sendRequest(
            apiBuilder: FriendAPIRequester.sendRequest(username: username),
            responseModel: FriendRequestModel.self
        )
    }

    static func delete(username: String) async throws {
        try await NetworkService.shared.sendRequest(
            apiBuilder: FriendAPIRequester.removeFriend(username: username)
        )
    }

    static func answerRequest(id: Int, answer: Bool) async throws -> FriendRequestAcceptedModel {
        return try await NetworkService.shared.sendRequest(
            apiBuilder: FriendAPIRequester.acceptOrReject(requestID: id, accepted: answer),
            responseModel: FriendRequestAcceptedModel.self
        )
    }

}
