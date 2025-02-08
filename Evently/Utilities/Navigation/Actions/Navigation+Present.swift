//
//  Navigation+Present.swift
//  Evently
//
//  Created by Theo Sementa on 06/02/2025.
//

import Foundation
import NavigationKit
import SwiftUICore

extension Router where Destination == NavigationDestination {

    func presentAddFriend(onDismiss: (() -> Void)? = nil) {
        presentSheet(.addFriend, onDismiss)
    }

    func presentCreateCategory(onDismiss: (() -> Void)? = nil) {
        presentSheet(.createCategory, onDismiss)
    }

    func presentCreateFolder(onDismiss: (() -> Void)? = nil) {
        presentSheet(.createFolder, onDismiss)
    }

    func presentSelectCategory(selectedCategory: Binding<CategoryModel?>) {
        presentSheet(.selectCategory(selectedCategory: selectedCategory))
    }

    func presentSelectFolder(selectedFolder: Binding<FolderModel?>) {
        presentSheet(.selectFolder(selectedFolder: selectedFolder))
    }

    func presentSelectedFriends(selectedFriends: Binding<[UserModel]>) {
        presentSheet(.selectFriends(selectedFriends: selectedFriends))
    }

}
