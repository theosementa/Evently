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
    case profile
    case myFriends
    case myFriendRequests

    case addFriend

    case createCategory
    case createFolder
    case createEvent

    case selectCategory(selectedCategory: Binding<CategoryModel?>)
    case selectFolder(selectedFolder: Binding<FolderModel?>)
    case selectFriends(selectedFriends: Binding<[UserModel]>)

    // swiftlint:disable:next cyclomatic_complexity
    func body(route: Route) -> some View {
        switch self {

        case .stepTwo:
            StepTwoView()

        case .home:
            HomeView()
        case .profile:
            ProfileView()
        case .myFriends:
            MyFriendsView()
        case .myFriendRequests:
            MyFriendRequestsView()

        case .addFriend:
            AddFriendView()

        case .createCategory:
            CreateCategoryView()
        case .createFolder:
            CreateFolderView()
        case .createEvent:
            CreateEventView()

        case let .selectCategory(selectedCategory):
            SelectCategoryView(selectedCategory: selectedCategory)
        case let .selectFolder(selectedFolder):
            SelectFolderView(selectedFolder: selectedFolder)
        case let .selectFriends(selectedFriends):
            SelectFriendsView(selectedFriends: selectedFriends)
        }
    }

    var id: Self { return self }

}

extension NavigationDestination {
    static func == (lhs: NavigationDestination, rhs: NavigationDestination) -> Bool {
        switch (lhs, rhs) {
        case (.stepTwo, .stepTwo),

            (.home, .home),
            (.profile, .profile),
            (.myFriends, .myFriends),
            (.myFriendRequests, .myFriendRequests),

            (.addFriend, .addFriend),

            (.createCategory, .createCategory),
            (.createFolder, .createFolder),
            (.createEvent, .createEvent),

            (.selectCategory, .selectCategory),
            (.selectFolder, .selectFolder),
            (.selectFriends, .selectFriends):
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
