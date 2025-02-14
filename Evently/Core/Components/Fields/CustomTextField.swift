//
//  CustomTextField.swift
//  Evently
//
//  Created by Theo Sementa on 05/02/2025.
//

import SwiftUI

struct CustomTextField: View {

    @Binding var text: String
    var config: Configuration

    @FocusState var isFocused: Bool

    // MARK: -
    var body: some View {
        VStack(spacing: 6) {
            Text(config.title)
                .font(.Content.smallSemiBold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 8)

            Group {
                if config.isSecured {
                    SecureField(config.placeholder, text: $text)
                } else {
                    TextField(config.placeholder, text: $text)
                }
            }
            .autocorrectionDisabled(true)
            .keyboardType(.alphabet)
            .focused($isFocused)
            .font(.Content.mediumSemiBold)
            .padding(.horizontal)
            .padding(.vertical, 14)
            .background {
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .stroke(text.isEmpty ? Color.black200 : Color.white0, lineWidth: 2)
            }

            if !config.rules.isEmpty {
                VStack(spacing: 8) {
                    ForEach(config.rules, id: \.self) { rule in
                        HStack(spacing: 8) {
                            Image(rule.isActive ? .checkmarkCircle : .xmark)
                                .resizable()
                                .renderingMode(.template)
                                .frame(width: 18, height: 18)
                                .foregroundStyle(rule.isActive ? .green : .red)

                            Text(rule.text)
                                .font(.Content.smallSemiBold)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                }
                .padding(.leading, 8)
            }
        }
        .onTapGesture {
            isFocused = true
        }
    } // body
} // struct

extension CustomTextField {
    struct Configuration {
        var title: String
        var placeholder: String
        var isSecured: Bool = false
        var rules: [RuleLine] = []
    }

    struct RuleLine: Hashable {
        var isActive: Bool
        var text: String
    }
}

// MARK: - Preview
#Preview {
    VStack(spacing: 24) {
        CustomTextField(
            text: .constant("Sementa"),
            config: .init(
                title: "Nom",
                placeholder: "Dupont"
            )
        )
        CustomTextField(
            text: .constant(""),
            config: .init(
                title: "Prénom",
                placeholder: "Thomas"
            )
        )
        CustomTextField(
            text: .constant(""),
            config: .init(
                title: "Prénom",
                placeholder: "Thomas",
                rules: [
                    .init(
                        isActive: true,
                        text: "Rule for preview"
                    )
                ]
            )
        )
    }
    .padding()
    .background(Color.black0)
    .preferredColorScheme(.dark)
}
