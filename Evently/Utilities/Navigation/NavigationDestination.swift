//
//  NavigationDestination.swift
//  Evently
//
//  Created by Theo Sementa on 01/02/2025.
//

import NavigationKit
import SwiftUI

enum NavigationDestination: RoutedDestination, Identifiable, Hashable {

    case stepTwo

    case home
    case detailFitted
//    case detail(user: UserModel)

    func body(route: Route) -> some View {
        switch self {

        case .stepTwo:
            StepTwoView()

        case .home:
            ContentView()
        case .detailFitted:
            SwiftUIViewText()
//        case let .detail(user):
//            UserDetail(userID: user.id)
        }
    }

    var id: Self { return self }
}
