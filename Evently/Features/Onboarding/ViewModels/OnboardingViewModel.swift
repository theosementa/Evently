//
//  OnboardingViewModel.swift
//  Evently
//
//  Created by Theo Sementa on 09/02/2025.
//

import Foundation
import SwiftUI

@Observable
final class OnboardingViewModel {

    var isHeaderDisplayed: Bool = false
    var isButtonStepOneDisplayed: Bool = false
    var isButtonStepTwoDisplayed: Bool = false

    var onboardingCurrentStep: Int = 1
    var shownTexts: Set<Int> = []

    var onboardingStep1Texts: [String] = [
        "onboarding_textOne".localized,
        "onboarding_textTwo".localized,
        "onboarding_textThree".localized
    ]

    var onboardingStep2Texts: [String] = [
        "onboarding_textFour".localized,
        "onboarding_textFive".localized
    ]

}

extension OnboardingViewModel {

    private func calculateTotalAnimationDuration(for textsCount: Int) -> Double {
        return Double(textsCount - 1) * 1.2 + 0.8
    }

    func playStepOneAnimation() {
        shownTexts.removeAll()
        isButtonStepOneDisplayed = false

        let totalDuration = calculateTotalAnimationDuration(for: onboardingStep1Texts.count)

        for index in onboardingStep1Texts.indices {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 1.2) {
                self.shownTexts.insert(index)
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + totalDuration) {
            withAnimation(.smooth(duration: 0.8)) {
                self.isButtonStepOneDisplayed = true
            }
        }
    }

    func playStepTwoAnimation() {
        shownTexts.removeAll()
        isButtonStepTwoDisplayed = false

        let totalDuration = calculateTotalAnimationDuration(for: onboardingStep1Texts.count)

        for index in onboardingStep2Texts.indices {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 1.4) {
                self.shownTexts.insert(index)
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + totalDuration) {
            withAnimation(.smooth(duration: 0.8)) {
                self.isButtonStepTwoDisplayed = true
            }
        }
    }

}
