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

    // MARK: -
    var body: some View {
        VStack {
            VStack(spacing: 16) {
                HStack(spacing: 16) {
                    TinyActionButton(icon: .person, action: { })

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

            ForEach(eventStore.events) { event in
                Text(event.name ?? "")
            }

            Spacer()
        }
        .padding(.horizontal, 24)
        .padding(.top)
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
                .padding(24)
        }
    } // body
} // struct

// MARK: - Preview
#Preview {
    HomeView()
        .preferredColorScheme(.dark)
}
