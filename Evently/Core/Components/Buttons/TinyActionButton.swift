//
//  TinyActionButton.swift
//  Evently
//
//  Created by Theo Sementa on 05/02/2025.
//

import SwiftUI

struct TinyActionButton: View {

    var icon: ImageResource
    var customBackground: AnyShapeStyle?
    var action: () async -> Void

    // MARK: -
    var body: some View {
        Button(action: {
            Task { await action() }
        }, label: {
            Image(icon)
                .padding(6)
                .background {
                    if let customBackground {
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(customBackground)
                    } else {
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(Color.black100)
                            .overlay {
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .stroke(Color.black200, lineWidth: 0.5)
                            }
                    }
                }
        })
    } // body
} // struct

// MARK: - Preview
#Preview {
    TinyActionButton(icon: .person) { }
        .padding()
        .background(Color.black0)
        .preferredColorScheme(.dark)
}
