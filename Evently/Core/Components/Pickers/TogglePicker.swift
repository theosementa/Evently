//
//  TogglePicker.swift
//  Evently
//
//  Created by Theo Sementa on 12/02/2025.
//

import SwiftUI
import NavigationKit

struct TogglePicker: View {

    @Binding var isSelected: Bool
    var title: String
    var text: String

    // MARK: -
    var body: some View {
        VStack(spacing: 6) {
            Text(title)
                .font(.Content.smallSemiBold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 8)
            
            HStack(spacing: 8) {
                Text(text)
                    .font(.Content.mediumBold)
                    .contentTransition(.numericText())
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                RoundedRectangle(cornerRadius: 6, style: .continuous)
                    .fill(isSelected ? Color.white : Color.clear)
                    .stroke(Color.white, lineWidth: isSelected ? 0 : 2)
                    .frame(width: 20, height: 20)
                    .overlay {
                        if isSelected {
                            Image(.iconCheckmark)
                                .resizable()
                                .renderingMode(.template)
                                .foregroundStyle(Color.black100)
                                .frame(width: 12, height: 12)
                        }
                    }
            }
            .foregroundStyle(Color.white0)
            .padding(.horizontal)
            .padding(.vertical, 14)
            .frame(maxWidth: .infinity )
            .background {
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(Color.black100)
                    .stroke(Color.black200, lineWidth: 1)
            }
        }
    } // body
} // struct

// MARK: - Preview
#Preview {
    VStack(spacing: 16) {
        TogglePicker(
            isSelected: .constant(true),
            title: "Durée de l'événement",
            text: "Toute la journée"
        )
        
        TogglePicker(
            isSelected: .constant(false),
            title: "Durée de l'événement",
            text: "Toute la journée"
        )
    }
        .padding()
        .background(Color.black0)
        .preferredColorScheme(.dark)
}
