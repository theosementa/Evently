//
//  EventlyWidget.swift
//  EventlyWidget
//
//  Created by Theo Sementa on 10/02/2025.
//

import WidgetKit
import SwiftUI

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
