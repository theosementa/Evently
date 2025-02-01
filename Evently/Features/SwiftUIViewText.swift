//
//  SwiftUIViewText.swift
//  Evently
//
//  Created by Theo Sementa on 01/02/2025.
//

import SwiftUI

struct SwiftUIViewText: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world FROM FITTED!")
                .font(.Headline.head3)
        }
        .padding()
    }
}

#Preview {
    SwiftUIViewText()
}
