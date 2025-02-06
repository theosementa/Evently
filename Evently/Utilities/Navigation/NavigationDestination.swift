//
//  NavigationDestination.swift
//  Evently
//
//  Created by Theo Sementa on 01/02/2025.
//

import NavigationKit
import SwiftUI

enum NavigationDestination: RoutedDestination, Identifiable {

    case stepTwo

    case home

    case createEvent
    case selectCategory(selectedCategory: Binding<CategoryModel?>)

    func body(route: Route) -> some View {
        switch self {

        case .stepTwo:
            StepTwoView()

        case .home:
            HomeView()

        case .createEvent:
            CreateEventView()
        case let .selectCategory(selectedCategory):
            SelectCategoryView(selectedCategory: selectedCategory)
        }
    }

    var id: Self { return self }

}

extension NavigationDestination {
    static func == (lhs: NavigationDestination, rhs: NavigationDestination) -> Bool {
        switch (lhs, rhs) {
        case (.stepTwo, .stepTwo),
            (.home, .home),
            (.createEvent, .createEvent),
            (.selectCategory, .selectCategory):
            return true

        default:
            return false
        }
    }
}

extension NavigationDestination: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
