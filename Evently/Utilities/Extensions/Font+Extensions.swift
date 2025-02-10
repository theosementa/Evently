//
//  Font+Extensions.swift
//  Evently
//
//  Created by Theo Sementa on 31/01/2025.
//

import SwiftUI

extension Font {

    static let customFont: String = "Nunito"

    struct Headline {
        static let head3: Font = .custom(customFont + "-Bold", size: 40)
        static let head4: Font = .custom(customFont + "-Bold", size: 32)
        static let head5: Font = .custom(customFont + "-Bold", size: 24)
    }

    struct Content {
        static let xlBold: Font = .custom(customFont + "-Bold", size: 20)
        static let xlSemiBold: Font = .custom(customFont + "-SemiBold", size: 20)

        static let largeExtraBold: Font = .custom(customFont + "-ExtraBold", size: 18)
        static let largeBold: Font = .custom(customFont + "-Bold", size: 18)
        static let largeSemiBold: Font = .custom(customFont + "-SemiBold", size: 18)
        static let largeMedium: Font = .custom(customFont + "-Medium", size: 18)

        static let mediumBold: Font = .custom(customFont + "-Bold", size: 16)
        static let mediumSemiBold: Font = .custom(customFont + "-SemiBold", size: 16)
        static let mediumMedium: Font = .custom(customFont + "-Medium", size: 16)

        static let smallBold: Font = .custom(customFont + "-Bold", size: 14)
        static let smallSemiBold: Font = .custom(customFont + "-SemiBold", size: 14)
    }

}

// MARK: - Preview
#Preview {
    VStack(spacing: 48) {
        VStack(alignment: .leading, spacing: 16) {
            Text("Headline 3")
                .font(.Headline.head3)
            Text("Headline 4")
                .font(.Headline.head4)
            Text("Headline 5")
                .font(.Headline.head5)
        }

        VStack(alignment: .leading, spacing: 32) {
            VStack(alignment: .leading, spacing: 16) {
                Text("Content - XL - Bold")
                    .font(.Content.xlBold)
                Text("Content - XL - SemiBold")
                    .font(.Content.xlSemiBold)
            }

            VStack(alignment: .leading, spacing: 16) {
                Text("Content - L - Bold")
                    .font(.Content.largeBold)
                Text("Content - L - SemiBold")
                    .font(.Content.largeSemiBold)
                Text("Content - L - Medium")
                    .font(.Content.largeMedium)
            }

            VStack(alignment: .leading, spacing: 16) {
                Text("Content - M - Bold")
                    .font(.Content.mediumBold)
                Text("Content - M - SemiBold")
                    .font(.Content.mediumSemiBold)
                Text("Content - M - Medium")
                    .font(.Content.mediumMedium)
            }

            VStack(alignment: .leading, spacing: 16) {
                Text("Content - S - SemiBold")
                    .font(.Content.smallSemiBold)
            }
        }
    }
}
