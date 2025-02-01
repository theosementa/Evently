//
//  ContentView.swift
//  Evently
//
//  Created by Theo Sementa on 28/01/2025.
//

import SwiftUI

struct ContentView: View {

    @Environment(AppManager.self) private var appManager

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
                .font(.Headline.head3)
        }
        .padding()
        .background(
            LinearGradient(
                colors: [
                    Color(hex: "FF5AAC"),
                    Color(hex: "FF5AAC").adjustLightness(percent: -10)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
        )
    }
}

#Preview {
    ContentView()
        .environment(AppManager())
}
