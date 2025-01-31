//
//  LottieView.swift
//  Evently
//
//  Created by Theo Sementa on 31/01/2025.
//

import Lottie
import SwiftUI

struct LottieView: UIViewRepresentable {
    var filename: String
    var loopMode: LottieLoopMode
    var animationDuration: Double?
    var onStart: () -> Void
    var onCompletion: () -> Void

    func makeUIView(context: Context) -> UIView {
        let animationView = LottieAnimationView(name: filename)
        animationView.loopMode = loopMode
        animationView.contentMode = .scaleAspectFit

        // Execute the onStart closure
        onStart()

        // Play the animation with a completion handler
        animationView.play { (finished) in
            if finished {
                onCompletion()
            }
        }

        // Stop the animation after the specified duration
        if let animationDuration {
            DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
                animationView.stop()
                onCompletion()
            }
        }

        return animationView
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {}
}
