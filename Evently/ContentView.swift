//
//  ContentView.swift
//  Evently
//
//  Created by Theo Sementa on 28/01/2025.
//

import SwiftUI
import NavigationKit

struct ContentView: View {

    @Environment(AppManager.self) private var appManager
    @EnvironmentObject private var router: Router<NavigationDestination>

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
                .font(.Headline.head3)
            RoutedNavigationButton(present: router.presentModalFitted()) {
                Text("Will fit ???")
            }

            RoutedNavigationButton(present: router.pushDetail()) {
                Text("NOOOOO fit ???")
            }

            RoutedNavigationButton(present: router.presentDetailAppleLike()) {
                Text("Apple manual")
            }
        }
        .padding()
        .background(
            LinearGradient(colorHex: "FF5AAC")
        )
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black0)
    }
}

#Preview {
    ContentView()
        .environment(AppManager())
}
