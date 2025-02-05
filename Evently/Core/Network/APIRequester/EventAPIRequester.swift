//
//  EventAPIRequester.swift
//  Evently
//
//  Created by Theo Sementa on 03/02/2025.
//

import Foundation

enum EventAPIRequester: APIRequestBuilder {
    case fetchEvents
    case createEvent(event: EventModel)
    case updateEvent(id: Int, event: EventModel)
    case deleteEvent(id: Int)
    case shareEvent(id: Int)
}

extension EventAPIRequester {
    var path: String {
        switch self {
        case .fetchEvents:
            return NetworkPath.Event.base
        case .createEvent:
            return NetworkPath.Event.base
        case .updateEvent(let id, _):
            return NetworkPath.Event.eventWithId(id: id)
        case .deleteEvent(let id):
            return NetworkPath.Event.eventWithId(id: id)
        case .shareEvent(let id):
            return NetworkPath.Event.share(id: id)
        }
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .fetchEvents:  return .GET
        case .createEvent:  return .POST
        case .updateEvent:  return .PUT
        case .deleteEvent:  return .DELETE
        case .shareEvent:   return .POST
        }
    }

    var parameters: [URLQueryItem]? {
        return nil
    }

    var isTokenNeeded: Bool {
        return true
    }

    var body: Data? {
        switch self {
        case .createEvent(let event):
            return try? JSONEncoder().encode(event)
        case .updateEvent(_, let event):
            return try? JSONEncoder().encode(event)
        default:
            return nil
        }
    }
}
