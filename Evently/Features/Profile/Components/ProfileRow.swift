//
//  ProfileRow.swift
//  Evently
//
//  Created by Theo Sementa on 08/02/2025.
//

import SwiftUI

struct ProfileRow: View {

    // builder
    var icon: ImageResource
    var title: String
    var isPushable: Bool

    // MARK: -
    var body: some View {
        HStack {
            Image(icon)
                .resizable()
                .frame(width: 20, height: 20)

            Text(title)
                .font(.Content.mediumSemiBold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(Color.white0)

            Image(isPushable ? .chevronRight : .arrowDiagonal)
                .resizable()
                .frame(width: 20, height: 20)
        }
        .padding(.horizontal)
        .padding(.vertical, 14)
        .background {
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color.black100)
                .stroke(Color.black200, lineWidth: 1)
        }
    } // body
} // struct

// MARK: - Preview
#Preview {
    ProfileRow(icon: .person, title: "My friends", isPushable: true)
        .preferredColorScheme(.dark)
        .padding()
        .background(Color.black0)
}
