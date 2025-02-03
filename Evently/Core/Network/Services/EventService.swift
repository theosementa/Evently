//
//  EventService.swift
//  Evently
//
//  Created by Theo Sementa on 03/02/2025.
//

import Foundation

struct EventService {
    
    static func fetchEvents() async throws -> [EventModel] {
        return try await NetworkService.shared.sendRequest(
            apiBuilder: EventAPIRequester.fetchEvents,
            responseModel: [EventModel].self
        )
    }
    
    static func createEvent(event: EventModel) async throws -> EventModel {
        return try await NetworkService.shared.sendRequest(
            apiBuilder: EventAPIRequester.createEvent(event: event),
            responseModel: EventModel.self
        )
    }
    
    static func updateEvent(id: Int, event: EventModel) async throws -> EventModel {
        return try await NetworkService.shared.sendRequest(
            apiBuilder: EventAPIRequester.updateEvent(id: id, event: event),
            responseModel: EventModel.self
        )
    }
    
    static func deleteEvent(id: Int) async throws {
        try await NetworkService.shared.sendRequest(
            apiBuilder: EventAPIRequester.deleteEvent(id: id)
        )
    }
    
    static func shareEvent(id: Int) async throws {
        try await NetworkService.shared.sendRequest(
            apiBuilder: EventAPIRequester.shareEvent(id: id)
        )
    }
    
}
