//
//  CategoryAPIRequester.swift
//  Evently
//
//  Created by Theo Sementa on 02/02/2025.
//

import Foundation

enum CategoryAPIRequester: APIRequestBuilder {
    case fetchCategories
    case createCategory(body: CategoryModel)
    case fetchCategoriesDefaults
    case updateCategory(id: Int, body: CategoryModel)
    case deleteCategory(id: Int)
}

extension CategoryAPIRequester {
    var path: String {
        switch self {
        case .fetchCategories:
            return NetworkPath.Category.base
        case .createCategory:
            return NetworkPath.Category.base
        case .fetchCategoriesDefaults:
            return NetworkPath.Category.default
        case .updateCategory(let id, _):
            return NetworkPath.Category.categoryWithId(id: id)
        case .deleteCategory(let id):
            return NetworkPath.Category.categoryWithId(id: id)
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .fetchCategories:          return .GET
        case .createCategory:           return .POST
        case .fetchCategoriesDefaults:  return .GET
        case .updateCategory:           return .PUT
        case .deleteCategory:           return .DELETE
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
        case .createCategory(let body):
            return try? JSONEncoder().encode(body)
        case .updateCategory(_, body: let body):
            return try? JSONEncoder().encode(body)
        default:
            return nil
        }
    }
}
