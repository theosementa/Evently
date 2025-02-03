//
//  CategoryService.swift
//  Evently
//
//  Created by Theo Sementa on 02/02/2025.
//

import Foundation

struct CategoryService {
    
    static func fetchAll() async throws -> [CategoryModel] {
        return try await NetworkService.shared.sendRequest(
            apiBuilder: CategoryAPIRequester.fetchAll,
            responseModel: [CategoryModel].self
        )
    }
    
    static func fetchAllDefaults() async throws -> [CategoryModel] {
        return try await NetworkService.shared.sendRequest(
            apiBuilder: CategoryAPIRequester.fetchAllDefaults,
            responseModel: [CategoryModel].self
        )
    }
    
    static func create(category: CategoryModel) async throws -> CategoryModel {
        return try await NetworkService.shared.sendRequest(
            apiBuilder: CategoryAPIRequester.create(body: category),
            responseModel: CategoryModel.self
        )
    }
    
    static func update(id: Int, category: CategoryModel) async throws -> CategoryModel {
        return try await NetworkService.shared.sendRequest(
            apiBuilder: CategoryAPIRequester.update(id: id, body: category),
            responseModel: CategoryModel.self
        )
    }
    
    static func delete(id: Int) async throws {
        try await NetworkService.shared.sendRequest(
            apiBuilder: CategoryAPIRequester.delete(id: id)
        )
    }
    
}
