//
//  EventModelWidget.swift
//  Evently
//
//  Created by Theo Sementa on 10/02/2025.
//

import Foundation
import AppIntents
import SwiftUICore

struct EventModelWidget: AppEntity {
    let id: Int
    let name: String
    let date: Date
    let gradient: LinearGradient

    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Event"
    static var defaultQuery = EventModelQuery()

    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(title: "\(name)")
    }

    static var allEvents: [EventModelWidget] {
        return EventStore.shared.events.compactMap {
            guard let id = $0.id, let gradient = $0.category?.gradient else { return nil }
            return EventModelWidget(
                id: id,
                name: $0.name,
                date: $0.targetDate,
                gradient: gradient
            )
        }
    }
}

extension EventModelWidget {

    static let preview: EventModelWidget = .init(
        id: 1,
        name: "Preview Event",
        date: Date(),
        gradient: .init(gradient: Gradient(colors: [.blue, .red]), startPoint: .leading, endPoint: .trailing)
    )

}

struct EventModelQuery: EntityQuery {
    func entities(for identifiers: [EventModelWidget.ID]) async throws -> [EventModelWidget] {
        try await UserStore.shared.loginWithToken()

        _ = await CategoryStore.shared.fetchDefaults()
        _ = await CategoryStore.shared.fetchAll()
        _ = await EventStore.shared.fetchEvents()

        return EventModelWidget.allEvents.filter { identifiers.contains($0.id) }
    }

    func suggestedEntities() async throws -> [EventModelWidget] {
        try await UserStore.shared.loginWithToken()

        _ = await CategoryStore.shared.fetchDefaults()
        _ = await CategoryStore.shared.fetchAll()
        _ = await EventStore.shared.fetchEvents()

        return EventModelWidget.allEvents
    }

//    func suggestedEntities() async throws -> IntentItemCollection<EventModelWidget> {
//        var sections: [IntentItemSection<EventModelWidget>] = []
//
//        try await UserStore.shared.loginWithToken()
//
//        _ = await CategoryStore.shared.fetchDefaults()
//        _ = await CategoryStore.shared.fetchAll()
//        _ = await EventStore.shared.fetchEvents()
//
//        EventModelWidget.allEvents.forEach { event in
//            sections.append(.init(items: [.init(event)]))
//        }
//
//        return IntentItemCollection(sections: sections)
//    }

//    func defaultResult() async -> EventModelWidget? {
//        try? await suggestedEntities().first
//    }
}
