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
    var isRecurring: Bool?
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
        case isRecurring
        case folderId
        case recurrencePattern
        case interval
        case rawTargetDate = "targetDate"
        case categoryID
        case folderID
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
        if isRecurring == false {
            return EventFrequency.none
        } else {
            return EventFrequency(rawValue: recurrencePattern ?? "")
        }
    }

}
