//
//  ActionButton.swift
//  Evently
//
//  Created by Theo Sementa on 02/02/2025.
//

import SwiftUI

enum ActionButtonStyle {
    case `default`
    case reversed
    case secondary
    case secondaryReversed
    case google
}

struct ActionButton: View {

    // Builder
    var style: ActionButtonStyle
    var icon: ImageResource?
    var title: String
    var isFill: Bool = false
    var action: () -> Void

    // MARK: -
    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                if style == .reversed || style == .google || style == .secondaryReversed {
                    Text(title)
                        .frame(maxWidth: isFill ? .infinity : nil, alignment: .leading)
                }

                if let icon {
                    Image(icon)
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 20, height: 20)
                }

                if style != .reversed && style != .google && style != .secondaryReversed {
                    Text(title)
                }
            }
            .font(.Content.mediumBold)
            .foregroundStyle(foregroundColor)
            .padding(.horizontal)
            .padding(.vertical, 14)
            .frame(maxWidth: isFill ? .infinity : nil)
            .background {
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(backgroundColor)
                    .stroke(
                        (style == .secondary || style == .secondaryReversed)
                        ? Color.white0
                        : Color.clear, lineWidth: 2
                    )
            }
        }
    } // body
} // struct

extension ActionButton {

    var foregroundColor: Color {
        switch style {
        case .default:
            return Color.black
        case .reversed:
            return Color.black
        case .secondary:
            return Color.white
        case .google:
            return Color.white
        case .secondaryReversed:
            return Color.white
        }
    }

    var backgroundColor: Color {
        switch style {
        case .default:
            return Color.white
        case .reversed:
            return Color.white
        case .secondary:
            return Color.clear
        case .google:
            return Color(hex: "DB4A39")
        case .secondaryReversed:
            return Color.clear
        }
    }

}

// MARK: - Preview
#Preview {
    VStack(spacing: 16) {
        ActionButton(
            style: .default,
            icon: .calendar,
            title: "Mes événements"
        ) { }

        ActionButton(
            style: .default,
            icon: .calendar,
            title: "Mes événements",
            isFill: true
        ) { }

        ActionButton(
            style: .reversed,
            icon: .calendar,
            title: "Mes événements"
        ) { }

        ActionButton(
            style: .reversed,
            icon: .calendar,
            title: "Mes événements",
            isFill: true
        ) { }

        ActionButton(
            style: .secondary,
            icon: .calendar,
            title: "Mes événements"
        ) { }

        ActionButton(
            style: .default,
            title: "Terminer",
            isFill: true
        ) { }
    }
    .padding()
    .background(Color.secondary)
}
