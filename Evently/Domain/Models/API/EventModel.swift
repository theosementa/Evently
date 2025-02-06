//
//  EventModel.swift
//  Evently
//
//  Created by Theo Sementa on 03/02/2025.
//

import Foundation

struct EventModel: Codable, Identifiable {
    var id: Int?
    var name: String?
    var description: String?
    var folderId: Int?
    var recurrencePattern: String?
    var interval: Int?
    var rawTargetDate: String?
    var categoryID: Int?
    var folderID: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case folderId
        case recurrencePattern
        case interval
        case rawTargetDate = "targetDate"
        case categoryID
        case folderID
    }

    /// Default
    init(
        id: Int? = nil,
        name: String? = nil,
        description: String? = nil,
        folderId: Int? = nil,
        recurrencePattern: String? = nil,
        interval: Int? = nil,
        rawTargetDate: String? = nil,
        categoryID: Int? = nil,
        folderID: Int? = nil
    ) {
        self.id = id
        self.name = name
        self.description = description
        self.folderId = folderId
        self.recurrencePattern = recurrencePattern
        self.interval = interval
        self.rawTargetDate = rawTargetDate
        self.categoryID = categoryID
        self.folderID = folderID
    }

    /// Create event
    init(
        name: String,
        frequency: EventFrequency,
        categoryID: Int,
        targetDate: Date
    ) {
        self.name = name
        self.recurrencePattern = frequency.rawValue
        self.categoryID = categoryID
        self.rawTargetDate = targetDate.ISO8601Format(.iso8601)
    }

}

extension EventModel {

    var targetDate: Date {
        return rawTargetDate?.toDate() ?? .now
    }

    var category: CategoryModel? {
        return CategoryStore.shared.allCategories.first(where: { $0.id == self.categoryID })
    }

    var folder: FolderModel? {
        return FolderStore.shared.folders.first(where: { $0.id == self.folderID })
    }

    var frequency: EventFrequency? {
        return EventFrequency(rawValue: recurrencePattern ?? "")
    }

}
