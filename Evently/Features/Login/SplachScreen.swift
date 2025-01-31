//
//  SplachScreen.swift
//  Evently
//
//  Created by Theo Sementa on 31/01/2025.
//

import SwiftUI

struct SplachScreen: View {

    // Builder
    var onStart: () -> Void
    var completion: () -> Void

    // MARK: -
    var body: some View {
        VStack {
            LottieView(
                filename: "LottieSplashAnimationEvently",
                loopMode: .playOnce,
                animationDuration: 3,
                onStart: onStart,
                onCompletion: completion
            )
            .frame(width: UIScreen.main.bounds.width / 2)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    } // End body
} // End struct

// MARK: - Preview
#Preview {
    SplachScreen(onStart: { }, completion: { })
        .preferredColorScheme(.dark)
}
