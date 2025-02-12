//
//  EventStore.swift
//  Evently
//
//  Created by Theo Sementa on 03/02/2025.
//

import Foundation
import WidgetKit

@Observable
final class EventStore {
    static let shared = EventStore()

    var events: [EventModel] = []
}

extension EventStore {

    @MainActor
    func fetchEvents() async {
        do {
            let events = try await EventService.fetchEvents()
            self.events = events.sorted { $0.targetDate > $1.targetDate }
        } catch { NetworkService.handleError(error: error)  }
    }

    @discardableResult
    @MainActor
    func createEvent(event: EventModel) async -> EventModel? {
        do {
            let newEvent = try await EventService.createEvent(event: event)
            self.events.append(newEvent)
            self.events.sort { $0.targetDate > $1.targetDate }
            return newEvent
        } catch {
            NetworkService.handleError(error: error)
            return nil
        }
    }

    @MainActor
    func updateEvent(id: Int, event: EventModel) async {
        do {
            let updatedEvent = try await EventService.updateEvent(id: id, event: event)
            if let index = self.events.firstIndex(where: { $0.id == id }) {
                self.events[index] = updatedEvent
                self.events.sort { $0.targetDate > $1.targetDate }
                WidgetCenter.shared.reloadAllTimelines()
            }
        } catch { NetworkService.handleError(error: error)  }
    }

    @MainActor
    func deleteEvent(id: Int) async {
        do {
            try await EventService.deleteEvent(id: id)
            self.events.removeAll { $0.id == id }
            WidgetCenter.shared.reloadAllTimelines()
        } catch { NetworkService.handleError(error: error)  }
    }

    @MainActor
    func shareEvent(id: Int) async -> String? {
        do {
            let inviteToken = try await EventService.shareEvent(id: id).inviteToken
            return inviteToken
        } catch {
            NetworkService.handleError(error: error)
            return nil
        }
    }

    @MainActor
    func leaveEvent(id: Int) async {
        do {
            try await EventService.leaveEvent(id: id)
            self.events.removeAll { $0.id == id }
            WidgetCenter.shared.reloadAllTimelines()
        } catch {
            NetworkService.handleError(error: error)
        }
    }

}

extension EventStore {

    func findByID(_ id: Int) -> EventModel? {
        return events.first(where: { $0.id == id })
    }

}
