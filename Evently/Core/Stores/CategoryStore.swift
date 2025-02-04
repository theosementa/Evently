//
//  CategoryStore.swift
//  Evently
//
//  Created by Theo Sementa on 03/02/2025.
//

import Foundation

@Observable
final class CategoryStore {
    static let shared = CategoryStore()

    var categories: [CategoryModel] = []
    var defaultCategories: [CategoryModel] = []

    var allCategories: [CategoryModel] {
        return defaultCategories + categories
    }
}

extension CategoryStore {

    @MainActor
    func fetchAll() async {
        do {
            let categories = try await CategoryService.fetchAll()
            self.categories = categories
                .sorted { $0.name < $1.name }
        } catch { NetworkService.handleError(error: error) }
    }

    @MainActor
    func fetchDefaults() async {
        do {
            let categories = try await CategoryService.fetchAllDefaults()
            self.defaultCategories = categories
                .sorted { $0.name < $1.name }
        } catch { NetworkService.handleError(error: error) }
    }

    @MainActor
    func createCategory(category: CategoryModel) async {
        do {
            let newCategory = try await CategoryService.create(category: category)
            self.categories.append(newCategory)
            self.categories.sort { $0.name < $1.name }
        } catch { NetworkService.handleError(error: error) }
    }

    @MainActor
    func updateCategory(id: Int, category: CategoryModel) async {
        do {
            let updatedCategory = try await CategoryService.update(id: id, category: category)

            if let index = self.categories.firstIndex(where: { $0.id == id }) {
                self.categories[index] = updatedCategory
                self.categories.sort { $0.name < $1.name }
            }
        } catch { NetworkService.handleError(error: error) }
    }

    @MainActor
    func deleteCategory(id: Int) async {
        do {
            try await CategoryService.delete(id: id)

            if let index = self.categories.firstIndex(where: { $0.id == id }) {
                self.categories.remove(at: index)
            }
        } catch { NetworkService.handleError(error: error) }
    }

}
