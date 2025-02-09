//
//  OnboardingView.swift
//  Evently
//
//  Created by Theo Sementa on 09/02/2025.
//

import SwiftUI

struct OnboardingView: View {
    
    @State private var viewModel: OnboardingViewModel = .init()
    
    // MARK: -
    var body: some View {
        VStack(spacing: 32) {
            if viewModel.isHeaderDisplayed {
                VStack(spacing: 32) {
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 0) {
                            Text("onboarding_welcome".localized)
                            Text("Evently")
                        }
                        .font(.Headline.head4)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Image(.logoEvently)
                            .resizable()
                            .frame(width: 40, height: 40)
                            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    }
                    
                    Image(.havingFun)
                }
            }
            
            Group {
                if viewModel.onboardingCurrentStep == 1 {
                    VStack(alignment: .leading, spacing: 32) {
                        ForEach(viewModel.onboardingStep1Texts.indices, id: \.self) { index in
                            Text(viewModel.onboardingStep1Texts[index])
                                .font(.Content.largeSemiBold)
                                .opacity(viewModel.shownTexts.contains(index) ? 1 : 0)
                                .offset(y: viewModel.shownTexts.contains(index) ? 0 : 20)
                                .animation(.smooth(duration: 1.2), value: viewModel.shownTexts.contains(index))
                        }
                    }
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            viewModel.playStepOneAnimation()
                        }
                    }
                } else {
                    VStack(alignment: .leading, spacing: 32) {
                        ForEach(viewModel.onboardingStep2Texts.indices, id: \.self) { index in
                            Text(viewModel.onboardingStep2Texts[index])
                                .font(.Content.largeSemiBold)
                                .opacity(viewModel.shownTexts.contains(index) ? 1 : 0)
                                .offset(y: viewModel.shownTexts.contains(index) ? 0 : 20)
                                .animation(.smooth(duration: 1.2), value: viewModel.shownTexts.contains(index))
                        }
                    }
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            viewModel.playStepTwoAnimation()
                        }
                    }
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
                        
            if viewModel.onboardingCurrentStep == 1 && viewModel.isButtonStepOneDisplayed {
                ActionButton(
                    config: .init(
                        style: .default,
                        title: "global_continue".localized,
                        isFill: true
                    )
                ) {
                    viewModel.shownTexts.removeAll()
                    withAnimation(.smooth) {
                        viewModel.onboardingCurrentStep = 2
                    }
                }
            } else  if viewModel.onboardingCurrentStep == 2 && viewModel.isButtonStepTwoDisplayed {
                ActionButton(
                    config: .init(
                        style: .default,
                        icon: .sparkes,
                        title: "global_start".localized,
                        isFill: true
                    )
                ) {
                    
                }
            }
        }
        .padding(24)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation(.smooth(duration: 1.2)) {
                    viewModel.isHeaderDisplayed = true
                }
            }
        }
    } // body
} // struct

// MARK: - Preview
#Preview {
    OnboardingView()
        .preferredColorScheme(.dark)
}
