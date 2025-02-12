//
//  EventDetailView.swift
//  Evently
//
//  Created by Theo Sementa on 11/02/2025.
//

import SwiftUI
import NavigationKit

struct EventDetailView: View {

    // builder
    var eventID: Int

    @Environment(\.dismiss) private var dismiss
    @Environment(EventStore.self) private var eventStore
    @Environment(UserStore.self) private var userStore

    @EnvironmentObject private var router: Router<NavigationDestination>

    @State private var inviteToken: String?

    var event: EventModel? {
        return eventStore.findByID(eventID)
    }

    // MARK: -
    var body: some View {
        if let event, let userIdOfEvent = event.userID, let currentUser = userStore.currentUser {
            VStack(spacing: 16) {
                HStack(spacing: 16) {
                    TinyActionButton(icon: .chevronBack) { dismiss() }

                    Spacer()

                    TinyActionButton(icon: .edit) {
                        router.pushCreateEvent(event: event)
                    }

                    TinyActionButton(
                        icon: currentUser.isOwner(userIdOfEvent) ? .trash : .logout,
                        customBackground: AnyShapeStyle(LinearGradient.redGradient)
                    ) {
                        // TODO: Display alert
                    }
                }

                ScrollView {
                    VStack(spacing: 24) {
                        EventDetailRow(event: event)

                        if let inviteToken = event.inviteToken,
                           event.folder == nil,
                           currentUser.isOwner(userIdOfEvent) {
                            GenericBlock(
                                title: "detail_invite_link".localized,
                                description: "detail_share_link".localized,
                                centeredText: "evently-app.fr/\(inviteToken)",
                                button: .init(
                                    icon: .copy,
                                    title: "Copier le lien d’invitation",
                                    style: .default,
                                    action: {
                                        // TODO: Add invite link
                                    }
                                )
                            )
                        }
                    }
                    .padding(.horizontal, 1)
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
