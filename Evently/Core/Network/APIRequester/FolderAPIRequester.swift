//
//  FolderAPIRequester.swift
//  Evently
//
//  Created by Theo Sementa on 04/02/2025.
//

import Foundation

enum FolderAPIRequester: APIRequestBuilder {
    case fetchFolders
    case createFolder(folder: FolderModel)
    case updateFolder(id: Int, folder: FolderModel)
    case deleteFolder(id: Int)
    case leaveFolder(id: Int)
    case shareFolder(id: Int)
    case joinFolder(inviteToken: String)
}

extension FolderAPIRequester {
    var path: String {
        switch self {
        case .fetchFolders:
            return NetworkPath.Folder.base
        case .createFolder:
            return NetworkPath.Folder.base
        case .updateFolder(let id, _):
            return NetworkPath.Folder.folderWithId(id: id)
        case .deleteFolder(let id):
            return NetworkPath.Folder.folderWithId(id: id)
        case .leaveFolder(let id):
            return NetworkPath.Folder.leave(id: id)
        case .shareFolder(let id):
            return NetworkPath.Folder.share(id: id)
        case .joinFolder:
            return NetworkPath.Folder.join
        }
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .fetchFolders: return .GET
        case .createFolder: return .POST
        case .updateFolder: return .PUT
        case .deleteFolder: return .DELETE
        case .leaveFolder:  return .POST
        case .shareFolder:  return .POST
        case .joinFolder:   return .POST
        }
    }

    var parameters: [URLQueryItem]? {
        return nil
    }

    var isTokenNeeded: Bool {
        return true
    }

    var body: Data? {
        switch self {
        case .createFolder(let folder):
            return try? JSONEncoder().encode(folder)
        case .joinFolder(let inviteToken):
            return try? JSONEncoder().encode(["inviteToken": inviteToken])
        default:
            return nil
        }
    }
}
