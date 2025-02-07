//
//  CustomEmptyView.swift
//  Evently
//
//  Created by Theo Sementa on 07/02/2025.
//

import SwiftUI

struct CustomEmptyView: View {

    // builder
    var image: ImageResource
    var title: String
    var message: String

    // MARK: -
    var body: some View {
        VStack(spacing: 24) {
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(height: 180)

            VStack(spacing: 12) {
                Text(title)
                    .font(.Content.xlBold)

                Text(message)
                    .font(.Content.mediumSemiBold)
                    .multilineTextAlignment(.center)
            }
            .foregroundStyle(Color.white0)
        }
    } // body
} // struct

// MARK: - Preview
#Preview {
    CustomEmptyView(
        image: .emptyEvents,
        title: "home_empty_title".localized,
        message: "home_empty_desc".localized
    )
    .preferredColorScheme(.dark)
    .padding()
    .background(Color.black0)
}
