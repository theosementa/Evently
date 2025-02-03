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
    var targetDate: String?
    var categoryID: Int?
}
