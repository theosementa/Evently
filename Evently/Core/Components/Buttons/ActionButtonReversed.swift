//
//  ActionButtonReversed.swift
//  Evently
//
//  Created by Theo Sementa on 05/02/2025.
//

import SwiftUI

enum ActionButtonReversedStyle {
    case reversed
    case secondaryReversed
    case google
}

struct ActionButtonReversed: View {

    // Builder
    let config: Configuration
    let action: () async -> Void

    // MARK: -
    var body: some View {
        Button(action: {
            Task {
                await action()
            }
        }, label: {
            HStack(spacing: 8) {
                Text(config.title)
                    .frame(maxWidth: config.isTextFill ? .infinity : nil, alignment: .leading)

                Image(config.icon)
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 20, height: 20)
            }
            .font(.Content.mediumBold)
            .foregroundStyle(foregroundColor)
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
             .background {
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(backgroundColor)
                    .stroke(
                        config.style == .secondaryReversed ? Color.white0 : Color.clear,
                        lineWidth: 2
                    )
            }
        })
    } // body
} // struct

// MARK: - Configuration
extension ActionButtonReversed {

    struct Configuration {
        var style: ActionButtonReversedStyle
        var icon: ImageResource
        var title: String
        var isFill: Bool = false
        var isTextFill: Bool = false
    }

}

extension ActionButtonReversed {

    var foregroundColor: Color {
        switch config.style {
        case .reversed:
            return Color.black
        case .google:
            return Color.white
        case .secondaryReversed:
            return Color.white
        }
    }

    var backgroundColor: Color {
        switch config.style {
        case .reversed:
            return Color.white
        case .google:
            return Color(hex: "DB4A39")
        case .secondaryReversed:
            return Color.clear
        }
    }

}

// MARK: - Preview
#Preview {
    VStack(spacing: 32) {
        ActionButtonReversed(
            config: .init(
                style: .reversed,
                icon: .bike,
                title: "Preview"
            ),
            action: { }
        )

        ActionButtonReversed(
            config: .init(
                style: .google,
                icon: .google,
                title: "Google",
                isTextFill: true
            ),
            action: { }
        )
    }
    .padding()
    .preferredColorScheme(.dark)
}
