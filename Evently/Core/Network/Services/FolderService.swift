//
//  FolderService.swift
//  Evently
//
//  Created by Theo Sementa on 04/02/2025.
//

import Foundation

struct FolderService {
    
    static func fetchFolders() async throws -> [FolderModel] {
        return try await NetworkService.shared.sendRequest(
            apiBuilder: FolderAPIRequester.fetchFolders,
            responseModel: [FolderModel].self
        )
    }
    
    static func createFolder(folder: FolderModel) async throws -> FolderModel {
        return try await NetworkService.shared.sendRequest(
            apiBuilder: FolderAPIRequester.createFolder(folder: folder),
            responseModel: FolderModel.self
        )
    }
    
    static func updateFolder(id: Int, folder: FolderModel) async throws -> FolderModel {
        return try await NetworkService.shared.sendRequest(
            apiBuilder: FolderAPIRequester.updateFolder(id: id, folder: folder),
            responseModel: FolderModel.self
        )
    }
    
    static func deleteFolder(id: Int) async throws {
        try await NetworkService.shared.sendRequest(
            apiBuilder: FolderAPIRequester.deleteFolder(id: id)
        )
    }
    
}

extension FolderService {
    
    static func leaveFolder(id: Int) async throws {
        try await NetworkService.shared.sendRequest(
            apiBuilder: FolderAPIRequester.leaveFolder(id: id)
        )
    }
    
    static func shareFolder(id: Int) async throws -> InviteToken {
        return try await NetworkService.shared.sendRequest(
            apiBuilder: FolderAPIRequester.shareFolder(id: id),
            responseModel: InviteToken.self
        )
    }
    
    static func joinFolder(inviteToken: String) async throws {
        try await NetworkService.shared.sendRequest(
            apiBuilder: FolderAPIRequester.joinFolder(inviteToken: inviteToken)
        )
    }
    
}
