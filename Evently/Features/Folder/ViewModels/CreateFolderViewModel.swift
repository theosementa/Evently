//
//  CreateFolderViewModel.swift
//  Evently
//
//  Created by Theo Sementa on 08/02/2025.
//

import Foundation

@Observable
final class CreateFolderViewModel {

    var name: String = ""
    var selectedFriends: [UserModel] = []

}

extension CreateFolderViewModel {

    func createFolder() {
        Task {
            let friends = selectedFriends.compactMap(\.username)
            let newFolder = FolderModel(rawName: name, friends: friends)
            await FolderStore.shared.createFolder(folder: newFolder)
        }
    }

}
