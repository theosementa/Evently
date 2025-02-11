//
//  EventDetailView.swift
//  Evently
//
//  Created by Theo Sementa on 11/02/2025.
//

import SwiftUI

struct EventDetailView: View {

    // builder
    var eventID: Int

    @Environment(\.dismiss) private var dismiss
    @Environment(EventStore.self) private var eventStore

    var event: EventModel? {
        return eventStore.findByID(eventID)
    }

    // MARK: -
    var body: some View {
        if let event {
            VStack(spacing: 16) {
                HStack(spacing: 16) {
                    TinyActionButton(icon: .chevronBack) { dismiss() }
                    Spacer()
                    TinyActionButton(icon: .edit) { }
                    TinyActionButton(icon: .trash) { }
                }

                ScrollView {
                    EventDetailRow(event: event)
                }
                .scrollIndicators(.hidden)
                .contentMargins(.top, 32, for: .scrollContent)
                .clipShape(
                    UnevenRoundedRectangle(
                        topLeadingRadius: 24,
                        bottomLeadingRadius: 0,
                        bottomTrailingRadius: 0,
                        topTrailingRadius: 24,
                        style: .continuous
                    )
                )
            }
            .padding(.horizontal, 24)
            .background(Color.black0)
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
        }
    } // body
} // struct

// MARK: - Preview
#Preview {
    EventDetailView(eventID: 1)
}
