//
//  HomeView.swift
//  Evently
//
//  Created by Theo Sementa on 05/02/2025.
//

import SwiftUI
import NavigationKit

struct HomeView: View {

    @State private var viewModel: HomeViewModel = .init()
    @EnvironmentObject private var router: Router<NavigationDestination>
    @Environment(AppManager.self) private var appManager
    @Environment(EventStore.self) private var eventStore

    var filteredSections: [EventSection] {
        let filteredEvents: [EventModel]

        if viewModel.searchText.isEmpty {
            filteredEvents = viewModel.filterEvents(eventStore.events)
        } else {
            filteredEvents = viewModel.filterEvents(eventStore.events)
                .filter { $0.name.localizedStandardContains(viewModel.searchText) }
        }

        let sections = viewModel.groupEvents(filteredEvents)
        return sections
    }

    // MARK: -
    var body: some View {
        VStack(spacing: 24) {
            VStack(spacing: 16) {
                HStack(spacing: 16) {
                    TinyActionButton(icon: .person) {
                        router.pushProfile()
                    }

                    ActionButton(
                        config: .init(
                            style: .small,
                            icon: appManager.sideMenuItem.icon,
                            title: appManager.sideMenuItem.title,
                            customBackground: appManager.sideMenuItem.color != nil
                                ? AnyShapeStyle(appManager.sideMenuItem.color!)
                                : nil
                        )
                    ) { appManager.isSideMenuPresented.toggle() }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }

                CustomSearchBar(text: $viewModel.searchText)
            }
            .padding(.horizontal, 24)
            .padding(.top)

            let filteredEvents = viewModel.filterEvents(eventStore.events)
            if filteredEvents.isEmpty {
                VStack {
                    CustomEmptyView(
                        image: .emptyEvents,
                        title: "home_empty_title".localized,
                        message: "home_empty_desc".localized
                    )
                    .padding(.top)

                    Spacer()
                }
                .padding(.horizontal, 24)
                .padding(.top)
            } else {
                List {
                    ForEach(Array(filteredSections.enumerated()), id: \.element.title) { index, section in
                        Section {
                            ForEach(section.events) { event in
                                if let id = event.id {
                                    RoutedNavigationButton(push: router.pushEventDetail(eventID: id)) {
                                        EventRow(event: event)
                                    }
                                    .listRowSeparator(.hidden)
                                    .listRowBackground(Color.clear)
                                    .listRowInsets(.init(top: 8, leading: 0, bottom: 8, trailing: 0))
                                }
                            }

                            if index < filteredSections.count - 1 {
                                Separator()
                                    .listRowSeparator(.hidden)
                                    .listRowBackground(Color.clear)
                                    .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                            }
                        } header: {
                            Text(section.title)
                                .font(.Headline.head5)
                                .foregroundStyle(Color.white0)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal)
                                .padding(.bottom, 12)
                                .padding(.leading, 24)
                        }
                        .background(Color.black0)
                        .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                    }
                }
                .listStyle(.plain)
                .scrollIndicators(.hidden)
                .contentMargins(.bottom, 128, for: .scrollContent)
                .contentMargins(.horizontal, 24, for: .scrollContent)
                .ignoresSafeArea(.container, edges: .bottom)
                .animation(.smooth(duration: 1.2), value: appManager.sideMenuItem)
                .animation(.smooth(duration: 1.2), value: filteredSections.count)
                .animation(.smooth(duration: 1.2), value: filteredEvents.count)
                .refreshable {
                    await eventStore.fetchEvents()
                }
            }
        }
        .listSectionSpacing(-16)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black0)
        .overlay(alignment: . bottomTrailing) {
            ActionButton(
                config: .init(
                    style: .default,
                    icon: .calendar,
                    title: "add_event_title".localized
                )
            ) { router.pushCreateEvent() }
                .shadow(radius: 8, y: 4)
                .padding(24)
        }
    } // body
} // struct

// MARK: - Preview
#Preview {
    HomeView()
        .preferredColorScheme(.dark)
        .environment(AppManager.shared)
        .environment(EventStore.shared)
}
