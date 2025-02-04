//
//  AuthAPIRequester.swift
//  Split
//
//  Created by KaayZenn on 29/05/2024.
//

import Foundation

enum AuthAPIRequester: APIRequestBuilder {
    case apple(body: AuthBody)
    case google(body: AuthBody)
    case socket(body: AuthBody)
    case stepTwo(body: StepTwoBody)
}

extension AuthAPIRequester {
    var path: String {
        switch self {
        case .apple:
            return NetworkPath.Auth.apple
        case .google:
            return NetworkPath.Auth.google
        case .socket:
            return NetworkPath.Auth.socket
        case .stepTwo:
            return NetworkPath.Auth.stepTwo
        }
    }

    var httpMethod: HTTPMethod {
       return .POST
    }

    var parameters: [URLQueryItem]? {
        return nil
    }

    var isTokenNeeded: Bool {
        switch self {
        case .apple, .google:
            return false
        case .socket, .stepTwo:
            return true
        }
    }

    var body: Data? {
        switch self {
        case .apple(let body), .google(let body), .socket(let body):
            return try? JSONEncoder().encode(body)
        case .stepTwo(let body):
            return try? JSONEncoder().encode(body)
        }
    }
}
