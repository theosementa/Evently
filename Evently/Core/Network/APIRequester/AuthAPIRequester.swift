//
//  AuthAPIRequester.swift
//  Split
//
//  Created by KaayZenn on 29/05/2024.
//

import Foundation

enum AuthAPIRequester: APIRequestBuilder {
    case register(body: UserRegisterBody)
    case login(email: String, pasword: String)
    case refreshToken(refreshToken: String)
    case apple(body: AuthBody)
    case google(body: AuthBody)
    case socket(body: AuthBody)
}

extension AuthAPIRequester {
    var path: String {
        switch self {
        case .register:
            return NetworkPath.User.register
        case .login:
            return NetworkPath.User.login
        case .refreshToken(let refreshToken):
            return NetworkPath.User.refreshToken(refreshToken: refreshToken)
        case .apple:
            return NetworkPath.Auth.apple
        case .google:
            return NetworkPath.Auth.google
        case .socket:
            return NetworkPath.Auth.socket
        }
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .refreshToken:
            return .GET
        default:
            return .POST
        }
    }

    var parameters: [URLQueryItem]? {
        return nil
    }

    var isTokenNeeded: Bool {
        switch self {
        case .apple, .google, .register, .login, .refreshToken:
            return false
        case .socket:
            return true
        }
    }

    var body: Data? {
        switch self {
        case .register(let body):
            return try? JSONEncoder().encode(body)
        case .login(let email, let password):
            return try? JSONEncoder().encode(["email": email, "password": password])
        case .apple(let body):
            return try? JSONEncoder().encode(body)
        case .google(let body):
            return try? JSONEncoder().encode(body)
        case .socket(let body):
            return try? JSONEncoder().encode(body)
        default:
            return nil
        }
    }
}
