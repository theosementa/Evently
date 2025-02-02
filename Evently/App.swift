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

    @StateObject private var router = Router<NavigationDestination>(isPresented: .constant(.home))

    @State private var appManager: AppManager = .shared
    @State private var bannerManager: BannerManager = .shared

    // MARK: -
    var body: some Scene {
        WindowGroup {
            RoutedNavigationStack(router: router) {
                Group {
                    switch appManager.appState {
                    case .idle:
                        EmptyView()
                    case .loading:
                        SplachScreen(
                            onStart: {

                            }, completion: {
                                appManager.appState = .running
                            }
                        )
                    case .running:
                        ContentView()
                    case .needToLogin:
                        Text("needToLogin")
                    }
                }
            }
            .animation(.smooth, value: appManager.appState)
            .bannerView(banner: $bannerManager.banner)
            .environment(appManager)
            .environmentObject(router)
            .onAppear {
                appManager.appState = .loading
            }
        }
    } // body
} // struct
