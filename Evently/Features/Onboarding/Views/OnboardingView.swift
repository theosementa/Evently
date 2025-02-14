//
//  OnboardingView.swift
//  Evently
//
//  Created by Theo Sementa on 13/02/2025.
//

import SwiftUI

struct OnboardingView: View {

    @State var currentStep: Int = 0
    @State var showContent: Bool = false

    @Preference(\.hasOnboardingBeenSeen) private var hasOnboardingBeenSeen

    // MARK: -
    var body: some View {
        VStack {
            HStack(spacing: 16) {
                Image(.logoEvently)
                    .resizable()
                    .frame(width: 48, height: 48)
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))

                Text("Evently")
                    .font(.Headline.head3)
            }

            VStack(spacing: 32) {
                switch currentStep {
                case 1:
                    Group {
                        Image(.illuDatabase)
                            .resizable()
                            .scaledToFit()
                            .padding(.horizontal, 32)

                        VStack(spacing: 16) {
                            Text("onboarding_step_one_title".localized)
                                .font(.Headline.head5)

                            Text("onboarding_step_one_desc".localized)
                                .font(.Content.largeSemiBold)
                                .multilineTextAlignment(.center)
                        }
                    }
                    .opacity(showContent ? 1 : 0)
                case 2:
                    Group {
                        Image(.illuParty)
                            .resizable()
                            .scaledToFit()
                            .padding(.horizontal, 32)

                        VStack(spacing: 16) {
                            Text("onboarding_step_two_title".localized)
                                .font(.Headline.head5)

                            Text("onboarding_step_two_desc".localized)
                                .font(.Content.largeSemiBold)
                                .multilineTextAlignment(.center)
                        }
                    }
                    .opacity(showContent ? 1 : 0)
                case 3:
                    Group {
                        Image(.illuHangingOut)
                            .resizable()
                            .scaledToFit()
                            .padding(.horizontal, 32)

                        VStack(spacing: 16) {
                            Text("onboarding_step_three_title".localized)
                                .font(.Headline.head5)

                            Text("onboarding_step_three_desc".localized)
                                .font(.Content.largeSemiBold)
                                .multilineTextAlignment(.center)
                        }
                    }
                    .opacity(showContent ? 1 : 0)
                default:
                    EmptyView()
                }
            }
            .frame(maxHeight: .infinity)

            ActionButton(
                config: .init(
                    style: .default,
                    icon: currentStep == 3 ? .sparkes : nil,
                    title: currentStep == 3 ? "global_start".localized : "global_next".localized,
                    isFill: true
                )
            ) {
                if currentStep == 3 {
                    hasOnboardingBeenSeen = true
                } else {
                    playAnimation()
                }
            }
        }
        .padding(24)
        .onAppear {
            playAnimation()
        }
    } // body

    private func playAnimation() {
        withAnimation(.easeOut(duration: 1.6)) {
            showContent = false
        }

        withAnimation(.easeInOut) {
            currentStep += 1
        }

        withAnimation(.easeIn(duration: 1.4)) {
            showContent = true
        }
    }

} // struct

// MARK: - Preview
#Preview {
    OnboardingView()
        .preferredColorScheme(.dark)
}
