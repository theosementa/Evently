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

            Group {
                if config.isSecured {
                    SecureField(config.placeholder, text: $text)
                } else {
                    TextField(config.placeholder, text: $text)
                }
            }
            .focused($isFocused)
            .font(.Content.largeSemiBold)
            .padding(.horizontal)
            .padding(.vertical, 14)
            .background {
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .stroke(text.isEmpty ? Color.black200 : Color.white0, lineWidth: 2)
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
    }
    .padding()
    .background(Color.black0)
    .preferredColorScheme(.dark)
}
