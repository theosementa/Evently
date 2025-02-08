//
//  FriendAPIRequester.swift
//  Evently
//
//  Created by Theo Sementa on 07/02/2025.
//

import Foundation

enum FriendAPIRequester: APIRequestBuilder {
    case sendRequest(username: String)
    case removeFriend(username: String)
    case pendingRequests
    case getSentRequests
    case acceptOrReject(requestID: Int, accepted: Bool)
}

extension FriendAPIRequester {
    var path: String {
        switch self {
        case .sendRequest(let username):
            return NetworkPath.Friend.request(username: username)
        case .removeFriend(let username):
            return NetworkPath.Friend.request(username: username)
        case .pendingRequests:
            return NetworkPath.Friend.pendingRequests
        case .getSentRequests:
            return NetworkPath.Friend.sentRequests
        case .acceptOrReject(let requestID, _):
            return NetworkPath.Friend.acceptOrReject(requestID: requestID)
        }
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .sendRequest:      return .POST
        case .removeFriend:     return .DELETE
        case .pendingRequests:  return .GET
        case .getSentRequests:  return .GET
        case .acceptOrReject:   return .PUT
        }
    }

    var parameters: [URLQueryItem]? {
        return nil
    }

    var isTokenNeeded: Bool {
        return true
    }

    var body: Data? {
        switch self {
        case .acceptOrReject(_, let accepted):
            return try? JSONEncoder().encode(["accept": accepted])
        default:
            return nil
        }
    }
}
