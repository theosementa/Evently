//
//  EventlyApp.swift
//  Evently
//
//  Created by Theo Sementa on 28/01/2025.
//

import SwiftUI
import Observation
import NavigationKit

@main
struct EventlyApp: App {

    @StateObject private var router = Router<NavigationDestination>()
    @StateObject private var loginRouter = Router<NavigationDestination>()

    @State private var appManager: AppManager = .shared
    @State private var bannerManager: BannerManager = .shared

    @State private var userStore: UserStore = .shared

    // MARK: -
    var body: some Scene {
        WindowGroup {
            Group {
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
                        ContentView()
                    }
                case .needToLogin:
                    RoutedNavigationStack(router: loginRouter) {
                        LoginView(router: loginRouter)
                    }
                }
            }
            .animation(.smooth, value: appManager.appState)
            .bannerView(banner: $bannerManager.banner)
            .environment(appManager)
            .environment(bannerManager)
            .environment(userStore)
            .environmentObject(router)
            .onAppear {
                appManager.appState = .loading
            }
        }
    } // body
} // struct
