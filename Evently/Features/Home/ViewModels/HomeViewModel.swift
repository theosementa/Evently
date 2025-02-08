//
//  HomeViewModel.swift
//  Evently
//
//  Created by Theo Sementa on 05/02/2025.
//

import Foundation

@Observable
final class HomeViewModel {

    var searchText: String = ""

}

extension HomeViewModel {

    func filterEvents(_ events: [EventModel]) -> [EventModel] {
        let filteredEvents: [EventModel]
        switch AppManager.shared.sideMenuItem {
        case .events, .calendar:
            filteredEvents = events
        case .folder(let folderId):
            filteredEvents = events.filter { event in
                if let folderId { return event.folderID == folderId }
                return true
            }
        case .category(let categoryId):
            filteredEvents = events.filter { event in
                if let categoryId { return event.categoryID == categoryId }
                return true
            }
        }

        return filteredEvents
    }

    func groupEvents(_ events: [EventModel]) -> [EventSection] {
        let calendar = Calendar.current
        let currentYear = calendar.component(.year, from: .now)
        let currentMonth = calendar.component(.month, from: .now)

        let grouped = Dictionary(grouping: events) { event in
            let year = calendar.component(.year, from: event.targetDate)
            let month = calendar.component(.month, from: event.targetDate)

            if year == currentYear && month == currentMonth {
                return "home_this_month".localized
            } else if year == currentYear {
                return "home_later_this_year".localized
            } else if year == currentYear + 1 {
                return "home_next_year".localized
            } else {
                return "home_later_future".localized
            }
        }

        let sectionOrder = [
            "home_this_month".localized,
            "home_later_this_year".localized,
            "home_next_year".localized,
            "home_later_future".localized
        ]

        return sectionOrder.compactMap { title in
            if let sectionEvents = grouped[title], !sectionEvents.isEmpty {
                return EventSection(title: title, events: sectionEvents.sorted { $0.targetDate < $1.targetDate })
            }
            return nil
        }
    }

}
