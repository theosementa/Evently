//
//  EventSection.swift
//  Evently
//
//  Created by Theo Sementa on 07/02/2025.
//

import Foundation

struct EventSection: Identifiable {
    let title: String
    let events: [EventModel]
    var id: String { title }
}
