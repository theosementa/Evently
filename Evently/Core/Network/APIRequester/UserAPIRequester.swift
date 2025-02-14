//
//  UserAPIRequester.swift
//  HappyEat_iOS
//
//  Created by Theo Sementa on 09/03/2024.
//

import Foundation

enum UserAPIRequester: APIRequestBuilder {
    case me
    case register(body: UserModel)
    case login(email: String, pasword: String)
    case refreshToken(refreshToken: String)
    case update(body: UserModel)
    case delete
    case fetchFriends
    case isEmailAvailable(email: String)
}

extension UserAPIRequester {
    var path: String {
        switch self {
        case .me:
            return NetworkPath.User.me
        case .register:
            return NetworkPath.User.register
        case .login:
            return NetworkPath.User.login
        case .refreshToken(let refreshToken):
            return NetworkPath.User.refreshToken(refreshToken: refreshToken)
        case .update:
            return NetworkPath.User.base
        case .delete:
            return NetworkPath.User.base
        case .fetchFriends:
            return NetworkPath.User.friends
        case .isEmailAvailable(let email):
            return NetworkPath.User.isEmailAvailbale(email: email)
        }
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .me:           return .GET
        case .refreshToken: return .GET
        case .register:     return .POST
        case .login:        return .POST
        case .update:       return .PUT
        case .delete:       return .DELETE
        case .fetchFriends: return .GET
        case .isEmailAvailable: return .GET
        }
    }

    var parameters: [URLQueryItem]? { return nil }

    var isTokenNeeded: Bool {
        switch self {
        case .me:           return true
        case .refreshToken: return false
        case .register:     return false
        case .login:        return false
        case .update:       return true
        case .delete:       return true
        case .fetchFriends: return true
        case .isEmailAvailable: return false
        }
    }

    var body: Data? {
        switch self {
        case .register(let body):
            return try? JSONEncoder().encode(body)
        case .login(let email, let password):
            return try? JSONEncoder().encode(["email": email, "password": password])
        case .update(let body):
            return try? JSONEncoder().encode(body)
        default:
            return nil
        }
    }

}
