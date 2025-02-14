//
//  EventModel.swift
//  Evently
//
//  Created by Theo Sementa on 03/02/2025.
//

import Foundation

struct EventModel: Codable, Identifiable {
    var id: Int?
    var rawName: String?
    var description: String?
    var folderId: Int?
    var recurrencePattern: String?
    var interval: Int?
    var rawTargetDate: String?
    var categoryID: Int?
    var folderID: Int?
    var friends: [String]?
    var userID: Int?
    var inviteToken: String?

    enum CodingKeys: String, CodingKey {
        case id
        case rawName = "name"
        case description
        case folderId
        case recurrencePattern
        case interval
        case rawTargetDate = "targetDate"
        case categoryID
        case folderID
        case friends
        case userID
        case inviteToken
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
        folderID: Int? = nil,
        friends: [String]? = nil,
        userID: Int? = nil,
        inviteToken: String? = nil
    ) {
        self.id = id
        self.rawName = name
        self.description = description
        self.folderId = folderId
        self.recurrencePattern = recurrencePattern
        self.interval = interval
        self.rawTargetDate = rawTargetDate
        self.categoryID = categoryID
        self.folderID = folderID
        self.friends = friends
        self.userID = userID
        self.inviteToken = inviteToken
    }

    /// Create event
    init(
        name: String,
        frequency: EventFrequency,
        categoryID: Int,
        targetDate: Date,
        inviteToken: String? = nil,
        folderID: Int? = nil,
        friends: [String]? = nil
    ) {
        self.rawName = name
        self.recurrencePattern = frequency.rawValue
        self.categoryID = categoryID
        self.rawTargetDate = targetDate.ISO8601Format(.iso8601)
        self.inviteToken = inviteToken
        self.folderID = folderID
        self.friends = friends
    }

}

extension EventModel {

    var name: String {
        return rawName ?? ""
    }

    var targetDate: Date {
        return rawTargetDate?.toDate() ?? .now
    }

    var remainingDays: Int {
        return targetDate.daysFromNow
    }

    var isToday: Bool {
        return remainingDays == 0
    }

    var isTomorrow: Bool {
        return remainingDays == 1
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

extension EventModel {

    static let preview: EventModel = .init(
        name: "Preview Event",
        frequency: .unique,
        categoryID: 1,
        targetDate: Date().addingTimeInterval(3600 * 24 * 12 * 300)
    )

}
