//
//  EventlyWidget.swift
//  EventlyWidget
//
//  Created by Theo Sementa on 10/02/2025.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> EventModelEntry {
        EventModelEntry(date: Date(), configuration: SelectEventIntent(), event: .preview)
    }

    func snapshot(for configuration: SelectEventIntent, in context: Context) async -> EventModelEntry {
        EventModelEntry(date: Date(), configuration: configuration, event: configuration.event)
    }

    func timeline(for configuration: SelectEventIntent, in context: Context) async -> Timeline<EventModelEntry> {
        await UserStore.shared.loginWithTokenWithoutThrow()
        _ = await EventStore.shared.fetchEvents()

        let eventForWidget = EventModelWidget.allEvents
        let entries = eventForWidget.map { EventModelEntry(date: Date(), configuration: configuration, event: $0) }

//        let currentDate = Date()
//        for hourOffset in 0 ..< 5 {
//            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
//            let entry = EventModelEntry(date: Date(), event: $0)
//            entries.append(entry)
//        }
//        
        let timeline = Timeline(entries: entries, policy: .never)
        return timeline
    }

//    func relevances() async -> WidgetRelevances<ConfigurationAppIntent> {
//        // Generate a list containing the contexts this widget is relevant in.
//    }
}

struct EventModelEntry: TimelineEntry {
    let date: Date
    let configuration: SelectEventIntent
    let event: EventModelWidget?
}

struct EventlyWidgetEntryView: View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            if let event = entry.configuration.event {
                Text(event.name)
                Text(event.date.formatted(date: .complete, time: .omitted))
            }
        }
    }
}

struct EventlyWidget: Widget {
    let kind: String = "EventlyWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(
            kind: kind,
            intent: SelectEventIntent.self,
            provider: Provider()
        ) { entry in
            EventlyWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
    }
}

// extension SelectEventIntent {
//    fileprivate static var smiley: SelectEventIntent {
//        let intent = SelectEventIntent()
//        return intent
//    }
//
//    fileprivate static var starEyes: SelectEventIntent {
//        let intent = SelectEventIntent()
//        return intent
//    }
// }

// #Preview(as: .systemSmall) {
//    EventlyWidget()
// } timeline: {
//    SimpleEntry(date: .now, configuration: .smiley)
//    SimpleEntry(date: .now, configuration: .starEyes)
// }
