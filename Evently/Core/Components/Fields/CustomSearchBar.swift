//
//  CustomSearchBar.swift
//  Evently
//
//  Created by Theo Sementa on 05/02/2025.
//

import SwiftUI

struct CustomSearchBar: View {

    @Binding var text: String
    var placeholder: String?

    @FocusState var isFocused: Bool

    // MARK: -
    var body: some View {
        HStack(spacing: 10) {
            Image(.magnifyingGlass)
                .resizable()
                .renderingMode(.template)
                .frame(width: 18, height: 18)
                .foregroundStyle(text.isEmpty ? Color.black400 : Color.white0)

            TextField(placeholder ?? "global_search".localized, text: $text)
                .focused($isFocused)
                .font(.Content.mediumSemiBold)
                .autocorrectionDisabled(true)
                .keyboardType(.alphabet)
        }
        .padding(.horizontal)
        .padding(.vertical, 14)
        .background {
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(text.isEmpty ? Color.black200 : Color.white0, lineWidth: 2)
        }
        .onTapGesture {
            isFocused = true
        }
    } // body
} // struct

// MARK: - Preview
#Preview {
    CustomSearchBar(text: .constant(""))
        .padding()
        .background(Color.black0)
        .preferredColorScheme(.dark)
}
