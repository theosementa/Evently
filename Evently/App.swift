//
//  EventlyApp.swift
//  Evently
//
//  Created by Theo Sementa on 28/01/2025.
//

import SwiftUI
import Observation

@main
struct EventlyApp: App {

    @State private var appManager: AppManager = .shared

    // MARK: -
    var body: some Scene {
        WindowGroup {
            VStack { // TODO: TEMP
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
                case .failed:
                    Text("Failed")
                }
            }
            .environment(appManager)
            .onAppear {
                appManager.appState = .loading
            }
        }
    } // body
} // struct
