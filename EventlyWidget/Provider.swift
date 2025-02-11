//
//  Provider.swift
//  Evently
//
//  Created by Theo Sementa on 11/02/2025.
//

import WidgetKit

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> EventModelEntry {
        EventModelEntry(date: Date(), configuration: SelectEventIntent())
    }

    func snapshot(for configuration: SelectEventIntent, in context: Context) async -> EventModelEntry {
        EventModelEntry(date: Date(), configuration: configuration)
    }

    func timeline(for configuration: SelectEventIntent, in context: Context) async -> Timeline<EventModelEntry> {
        await UserStore.shared.loginWithTokenWithoutThrow()
        _ = await CategoryStore.shared.fetchDefaults()
        _ = await CategoryStore.shared.fetchAll()
        _ = await EventStore.shared.fetchEvents()

        var entries: [EventModelEntry] = []

        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            entries.append(.init(date: entryDate, configuration: configuration))
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        return timeline
    }

//    func relevances() async -> WidgetRelevances<ConfigurationAppIntent> {
//        // Generate a list containing the contexts this widget is relevant in.
//    }
}
