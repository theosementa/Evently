//
//  FolderStore.swift
//  Evently
//
//  Created by Theo Sementa on 04/02/2025.
//

import Foundation

@Observable
final class FolderStore {
    static let shared = FolderStore()

    var folders: [FolderModel] = []
}

extension FolderStore {

    @MainActor
    func fetchFolders() async {
        do {
            let folders = try await FolderService.fetchFolders()
            self.folders = folders
                .sorted { $0.name < $1.name }
        } catch { NetworkService.handleError(error: error) }
    }

    @MainActor
    func createFolder(folder: FolderModel) async {
        do {
            let newFolder = try await FolderService.createFolder(folder: folder)
            self.folders.append(newFolder)
            self.folders.sort { $0.name < $1.name }
        } catch { NetworkService.handleError(error: error) }
    }

    @MainActor
    func updateFolder(id: Int, folder: FolderModel) async {
        do {
            let updatedFolder = try await FolderService.updateFolder(id: id, folder: folder)

            if let index = self.folders.firstIndex(where: { $0.id == id }) {
                self.folders[index] = folder
                self.folders.sort { $0.name < $1.name }
            }
        } catch { NetworkService.handleError(error: error) }
    }

    @MainActor
    func deleteFolder(id: Int) async {
        do {
            try await FolderService.deleteFolder(id: id)

            if let index = self.folders.firstIndex(where: { $0.id == id }) {
                self.folders.remove(at: index)
            }
        } catch { NetworkService.handleError(error: error) }
    }

}

extension FolderStore {

    @MainActor
    func leaveFolder(id: Int) async {
        do {
            try await FolderService.leaveFolder(id: id)

            if let index = self.folders.firstIndex(where: { $0.id == id }) {
                self.folders.remove(at: index)
            }
        } catch { NetworkService.handleError(error: error) }
    }

    @MainActor
    func shareFolder(id: Int) async -> InviteToken? {
        do {
            return try await FolderService.shareFolder(id: id)
        } catch {
            NetworkService.handleError(error: error)
            return nil
        }
    }

    @MainActor
    func joinFolder(inviteToken: String) async {
        do {
            try await FolderService.joinFolder(inviteToken: inviteToken)
            await self.fetchFolders()
        } catch {
            NetworkService.handleError(error: error)
        }
    }

}
