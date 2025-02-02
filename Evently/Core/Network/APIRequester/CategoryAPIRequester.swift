//
//  CategoryAPIRequester.swift
//  Evently
//
//  Created by Theo Sementa on 02/02/2025.
//

import Foundation

enum CategoryAPIRequester: APIRequestBuilder {
    case fetchAll
    case create(body: CategoryModel)
    case fetchAllDefaults
    case update(id: Int, body: CategoryModel)
    case delete(id: Int)
}

extension CategoryAPIRequester {
    var path: String {
        switch self {
        case .fetchAll:
            return NetworkPath.Category.base
        case .create:
            return NetworkPath.Category.base
        case .fetchAllDefaults:
            return NetworkPath.Category.default
        case .update(let id, _):
            return NetworkPath.Category.categoryWithId(id: id)
        case .delete(let id):
            return NetworkPath.Category.categoryWithId(id: id)
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .fetchAll:             return .GET
        case .create:               return .POST
        case .fetchAllDefaults:     return .GET
        case .update:               return .PUT
        case .delete:               return .DELETE
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
        case .create(let body):
            return try? JSONEncoder().encode(body)
        case .update(_, body: let body):
            return try? JSONEncoder().encode(body)
        default:
            return nil
        }
    }
}
