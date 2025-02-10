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
        _ = await CategoryStore.shared.fetchDefaults()
        _ = await CategoryStore.shared.fetchAll()
        _ = await EventStore.shared.fetchEvents()

        let eventForWidget = EventModelWidget.allEvents
        var entries: [EventModelEntry] = []

        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            entries = eventForWidget.map { EventModelEntry(date: entryDate, configuration: configuration, event: $0) }
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
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
        if let event = entry.configuration.event {
            VStack(spacing: 8) {
                Text(event.name)
                    .font(.Content.largeBold)
                    .lineLimit(2)
                    .multilineTextAlignment(.center)

                VStack(spacing: -2) {
                    Text(event.date.daysFromNow.formatted())
                        .font(.Headline.head4)
                    Text("detail_rest_time".localized)
                        .font(.Content.mediumSemiBold)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .padding()
            .background(event.gradient)
        } else {
            Text("No widget")
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
        .contentMarginsDisabled()
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
