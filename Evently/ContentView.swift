//
//  ContentView.swift
//  Evently
//
//  Created by Theo Sementa on 28/01/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
                .font(.custom("Nunito-Bold", size: 34))
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
