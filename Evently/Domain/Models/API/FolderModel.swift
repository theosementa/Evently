//
//  FolderModel.swift
//  Evently
//
//  Created by Theo Sementa on 04/02/2025.
//

import Foundation

struct FolderModel: Codable, Identifiable, Equatable {
    var id: Int?
    var rawName: String?
    var rawIcon: String?
    var friends: [String]?

    enum CodingKeys: String, CodingKey {
        case id
        case rawName = "name"
        case rawIcon = "icon"
        case friends
    }

    init(
        id: Int? = nil,
        rawName: String? = nil,
        rawIcon: String? = nil,
        friends: [String]? = nil
    ) {
        self.id = id
        self.rawName = rawName
        self.rawIcon = rawIcon
        self.friends = friends
    }

    /// create
    init(
        name: String,
        friends: [String]? = nil
    ) {
        self.rawName = name
        self.friends = friends
    }

}

extension FolderModel {
    var name: String {
        return rawName ?? ""
    }

    var icon: String {
        return rawIcon ?? "folder"
    }
}

extension FolderModel {

    static let preview: FolderModel = .init(
        id: 1,
        rawName: "Folder Preview",
        rawIcon: "folder"
    )

}
