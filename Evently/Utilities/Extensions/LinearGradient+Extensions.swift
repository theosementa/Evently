//
//  LinearGradient+Extensions.swift
//  Evently
//
//  Created by Theo Sementa on 01/02/2025.
//

import SwiftUICore

extension LinearGradient {

    init(colorHex: String) {
        self.init(
            colors: [
                Color(hex: colorHex),
                Color(hex: colorHex).adjustLightness(percent: -15)
            ],
            startPoint: .top,
            endPoint: .bottom
        )
    }

}
