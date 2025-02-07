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

    enum CodingKeys: String, CodingKey {
        case id
        case rawName = "name"
        case rawIcon = "icon"
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
