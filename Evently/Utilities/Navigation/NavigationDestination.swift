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
    case classicLogin
    case createAccount

    case home
    case profile
    case myFriends
    case myFriendRequests
    case mySentRequests
    case manageMyAccount

    case addFriend

    case createCategory
    case createFolder
    case createEvent(event: EventModel? = nil)

    case selectCategory(selectedCategory: Binding<CategoryModel?>)
    case selectFolder(selectedFolder: Binding<FolderModel?>)
    case selectFriends(selectedFriends: Binding<[UserModel]>)

    case eventDetail(eventID: Int)

    // swiftlint:disable:next cyclomatic_complexity
    func body(route: Route) -> some View {
        switch self {

        case .stepTwo:
            StepTwoView()
        case .classicLogin:
            ClassicLoginView()
        case .createAccount:
            ClassicCreateAccountView()

        case .home:
            HomeView()
        case .profile:
            ProfileView()
        case .myFriends:
            MyFriendsView()
        case .myFriendRequests:
            MyFriendRequestsView()
        case .mySentRequests:
            MySentRequestView()
        case .manageMyAccount:
            ManageMyAccountView()

        case .addFriend:
            AddFriendView()

        case .createCategory:
            CreateCategoryView()
        case .createFolder:
            CreateFolderView()
        case .createEvent(let event):
            CreateEventView(event: event)

        case let .selectCategory(selectedCategory):
            SelectCategoryView(selectedCategory: selectedCategory)
        case let .selectFolder(selectedFolder):
            SelectFolderView(selectedFolder: selectedFolder)
        case let .selectFriends(selectedFriends):
            SelectFriendsView(selectedFriends: selectedFriends)

        case let .eventDetail(eventID):
            EventDetailView(eventID: eventID)
        }
    }

    var id: Self { return self }

}

extension NavigationDestination {
    static func == (lhs: NavigationDestination, rhs: NavigationDestination) -> Bool {
        switch (lhs, rhs) {
        case (.stepTwo, .stepTwo),
            (.classicLogin, .classicLogin),

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
            (.selectFriends, .selectFriends),

            (.eventDetail, .eventDetail):
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
