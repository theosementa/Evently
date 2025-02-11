//
//  AppIntent.swift
//  EventlyWidget
//
//  Created by Theo Sementa on 10/02/2025.
//

import WidgetKit
import AppIntents

struct SelectEventIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Select a event"
    static var description = IntentDescription("Selects the character to display information for.")

    @Parameter(title: "Event")
    var event: EventModelWidget?
}
