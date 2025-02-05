//
//  SideBarSelection.swift
//  Evently
//
//  Created by Theo Sementa on 05/02/2025.
//

import Foundation
import SwiftUI

enum SideMenuSelection: Equatable {
    case events
    case calendar
    case folder(id: Int?)
    case category(id: Int?)

    var icon: ImageResource {
        switch self {
        case .events:
            return .sparkes
        case .calendar:
            return .calendar
        case .folder:
            return .folder
        case .category(let id):
            if let icon = CategoryStore.shared.allCategories.first(where: { $0.id == id })?.icon {
                return ImageResource(name: icon, bundle: .main)
            }
            return .sparkes
        }
    }

    var title: String {
        switch self {
        case .events:
            return "sidebar_my_events".localized
        case .calendar:
            return "sidebar_my_calendar".localized
        case .folder(let id):
            return FolderStore.shared.folders.first(where: { $0.id == id })?.name ?? "Folders"
        case .category(let id):
            return CategoryStore.shared.allCategories.first(where: { $0.id == id })?.name ?? "Categories"
        }
    }

    var color: (any ShapeStyle)? {
        switch self {
        case .category(let id):
            return CategoryStore.shared.allCategories.first(where: { $0.id == id })?.gradient
        default:
            return nil
        }
    }
}
