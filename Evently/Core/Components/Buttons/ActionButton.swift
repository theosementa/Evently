//
//  ActionButton.swift
//  Evently
//
//  Created by Theo Sementa on 02/02/2025.
//

import SwiftUI

enum ActionButtonStyle {
    case `default`
    case unselected
    case small
    case secondary
    case disabled
}

struct ActionButton: View {

    // Builder
    let config: Configuration
    let action: () async -> Void

    // MARK: -
    var body: some View {
        Button(action: {
            Task { await action() }
        }, label: {
            HStack(spacing: 8) {
                if let icon = config.icon {
                    Image(icon)
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 20, height: 20)
                }

                Text(config.title)
                    .font(.Content.mediumBold)
            }
            .foregroundStyle(foregroundColor)
            .padding(.horizontal, config.style == .small ? 12 : 16)
            .padding(.vertical, config.style == .small ? 8 : 14)
            .frame(maxWidth: config.isFill ? .infinity : nil, alignment: config.alignment)
            .background {
                RoundedRectangle(cornerRadius: config.style == .small ? 10 : 16, style: .continuous)
                    .fill(backgroundStyle)
                    .stroke(
                        config.style == .secondary ? Color.white0 : Color.clear,
                        lineWidth: 2
                    )
            }
        })
    } // body
} // struct

// MARK: - Configuration
extension ActionButton {
    struct Configuration {
        var style: ActionButtonStyle
        var icon: ImageResource?
        var title: String
        var isFill: Bool = false
        var alignment: Alignment = .center
        var customBackground: AnyShapeStyle?
    }
}

extension ActionButton {

    private var backgroundStyle: AnyShapeStyle {
        if let customBackground = config.customBackground, config.style != .unselected {
            customBackground
        } else {
            AnyShapeStyle(backgroundColor)
        }
    }

    var foregroundColor: Color {
        if config.customBackground != nil, config.style != .unselected {
            return Color.white
        } else {
            switch config.style {
            case .default:
                return Color.black
            case .unselected:
                return Color.black500
            case .small:
                return Color.black
            case .secondary:
                return Color.white
            case .disabled:
                return Color.white
            }
        }
    }

    var backgroundColor: Color {
        switch config.style {
        case .default:
            return Color.white
        case .unselected:
            return Color.clear
        case .small:
            return Color.white
        case .secondary:
            return Color.clear
        case .disabled:
            return Color.black200
        }
    }

}

// MARK: - Preview
#Preview {
    VStack(spacing: 16) {
        ActionButton(
            config: .init(
                style: .small,
                icon: .sparkes,
                title: "Mes événements"
            )
        ) { }

        ActionButton(
            config: .init(
                style: .default,
                icon: .sparkes,
                title: "Mes événements"
            )
        ) { }

        ActionButton(
            config: .init(
                style: .unselected,
                icon: .sparkes,
                title: "Mes événements"
            )
        ) { }

        ActionButton(
            config: .init(
                style: .default,
                icon: .sparkes,
                title: "Mes événements",
                isFill: true
            )
        ) { }
    }
    .padding()
    .background(Color.black0)
}
