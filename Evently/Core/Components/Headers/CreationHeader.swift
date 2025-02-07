//
//  CreationHeader.swift
//  Evently
//
//  Created by Theo Sementa on 07/02/2025.
//

import SwiftUI

struct CreationHeader: View {

    // builder
    var icon: ImageResource
    var title: String

    @Environment(\.dismiss) private var dismiss

    // MARK: -
    var body: some View {
        HStack {
            HStack(spacing: 12) {
                Image(icon)
                Text(title)
                    .font(.Content.xlBold)
            }
            Spacer()
            TinyActionButton(icon: .xmark) { dismiss() }
        }
    } // body
} // struct

// MARK: - Preview
#Preview {
    CreationHeader(icon: .person, title: "Person Preview")
        .preferredColorScheme(.dark)
        .padding()
        .background(Color.black0)
}
