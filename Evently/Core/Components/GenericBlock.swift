//
//  GenericBlock.swift
//  Evently
//
//  Created by Theo Sementa on 11/02/2025.
//

import SwiftUI

struct GenericBlock: View {

    // builder
    var title: String
    var description: String
    var centeredText: String?
    var button: ConfigurationButton?

    // MARK: -
    var body: some View {
        VStack(spacing: 32) {
            VStack(alignment: .leading, spacing: 16) {
                Text(title)
                    .font(.Content.xlBold)
                Text(description)
                    .multilineTextAlignment(.leading)
                    .font(.Content.mediumMedium)
            }

            if let centeredText {
                Text(centeredText)
                    .font(.Content.xlBold)
                    .multilineTextAlignment(.center)
            }

            if let button {
                if button.style == .default {
                    ActionButton(
                        config: .init(
                            style: .default,
                            icon: button.icon,
                            title: button.title,
                            isFill: true
                        ),
                        action: button.action
                    )
                } else {
                    if let icon = button.icon {
                        ActionButtonReversed(
                            config: .init(
                                style: .reversed,
                                icon: icon,
                                title: button.title,
                                isFill: true,
                                isTextFill: true
                            ),
                            action: button.action
                        )
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(24)
        .background {
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(Color.black100)
                .stroke(Color.black200, lineWidth: 1)
        }
    } // body
} // struct

extension GenericBlock {
    enum ConfigurationButtonStyle {
        case `default`
        case reversed
    }

    struct ConfigurationButton {
        var icon: ImageResource?
        var title: String
        var style: ConfigurationButtonStyle
        var action: () -> Void
    }
}

// MARK: - Preview
#Preview {
    GenericBlock(
        title: "detail_copy_link".localized,
        description: "detail_share_link".localized,
        button: .init(
            icon: .copy,
            title: "Copier le lien d’invitation",
            style: .default,
            action: { }
        )
    )
    .preferredColorScheme(.dark)
    .padding()

}
