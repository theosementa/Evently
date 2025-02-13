//
//  EventlyApp.swift
//  Evently
//
//  Created by Theo Sementa on 28/01/2025.
//

import SwiftUI
import Observation
import NavigationKit
import WidgetKit

@main
struct EventlyApp: App {

    @StateObject private var router = Router<NavigationDestination>()
    @StateObject private var loginRouter = Router<NavigationDestination>()

    @State private var appManager: AppManager = .shared
    @State private var bannerManager: BannerManager = .shared

    @State private var userStore: UserStore = .shared
    @State private var friendStore: FriendStore = .shared
    @State private var folderStore: FolderStore = .shared
    @State private var categoryStore: CategoryStore = .shared
    @State private var eventStore: EventStore = .shared

    @Preference(\.hasOnboardingBeenSeen) private var hasOnboardingBeenSeen

    // MARK: -
    var body: some Scene {
        WindowGroup {
            Group {
                ZStack {
                    switch appManager.appState {
                    case .idle:
                        EmptyView()
                    case .loading:
                        SplachScreen(
                            onStart: {
                                Task { await userStore.login() }
                            }, completion: {
                                if userStore.currentUser != nil {
                                    appManager.appState = .running
                                } else {
                                    AppManager.shared.appState = .needToLogin
                                }
                            }
                        )
                    case .running:
                        RoutedNavigationStack(router: router) {
                            HomeView()
                        }
                        .environmentObject(router)

                    case .needToLogin:
                        if !hasOnboardingBeenSeen {
                            OnboardingView()
                        } else {
                            RoutedNavigationStack(router: loginRouter) {
                                LoginView(router: loginRouter)
                            }
                            .environmentObject(loginRouter)
                        }
                    }

                    SideMenu(isShowing: $appManager.isSideMenuPresented) {
                        SideMenuView()
                    }
                    .environmentObject(router)
                }
            }
            .animation(.smooth, value: appManager.appState)
            .bannerView(banner: $bannerManager.banner)
            .environment(appManager)
            .environment(bannerManager)
            .environment(userStore)
            .environment(friendStore)
            .environment(folderStore)
            .environment(categoryStore)
            .environment(eventStore)
            .onAppear {
                appManager.appState = .loading
            }
            .onChange(of: appManager.appState) {
                if appManager.appState == .running {
                    WidgetCenter.shared.reloadAllTimelines()

                    Task {
                        async let friends: () = friendStore.fetchFriends()
                        async let folders: () = folderStore.fetchFolders()
                        async let categories: () = categoryStore.fetchAll()
                        async let defaults: () = categoryStore.fetchDefaults()
                        async let events: () = eventStore.fetchEvents()

                        _ = await (friends, folders, categories, defaults, events)
                    }
                }
            }
            .preferredColorScheme(.dark) // TODO: Remove when light mode available
        }
    } // body
} // struct
