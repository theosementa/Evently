//
//  StepTwoView.swift
//  Evently
//
//  Created by Theo Sementa on 04/02/2025.
//

import SwiftUI

struct StepTwoView: View {

    @State private var viewModel: LoginViewModel = .shared
    @State private var classicViewModel: ClassicLoginViewModel = .shared

    // MARK: -
    var body: some View {
        VStack(spacing: 48) {
            VStack(spacing: 32) {
                Text("auth_step_two".localized)
                    .font(.Content.largeMedium)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Separator()

                CustomTextField(
                    text: $viewModel.lastName,
                    config: .init(
                        title: "auth_last_name".localized,
                        placeholder: "Dupont"
                    )
                )

                CustomTextField(
                    text: $viewModel.firstName,
                    config: .init(
                        title: "auth_first_name".localized,
                        placeholder: "Thomas"
                    )
                )
            }

            ActionButton(
                config: .init(
                    style: .default,
                    icon: .sparkes,
                    title: "auth_end_button".localized,
                    isFill: true
                )
            ) {
                if classicViewModel.isInStepTwo {
                    if !classicViewModel.firstName.isEmpty && !classicViewModel.lastName.isEmpty {
                        if await classicViewModel.register() != nil {
                            AppManager.shared.appState = .running
                        }
                    }
                } else {
                    if !viewModel.firstName.isEmpty && !viewModel.lastName.isEmpty {
                        await viewModel.stepTwo()
                    }
                }
            }
        }
        .padding(24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black0)
        .navigationBarBackButtonHidden(true)
        .onChange(of: viewModel.firstName) {
            if classicViewModel.isInStepTwo {
                classicViewModel.firstName = viewModel.firstName
            }
        }
        .onChange(of: viewModel.lastName) {
            if classicViewModel.isInStepTwo {
                classicViewModel.lastName = viewModel.lastName
            }
        }
    } // body
} // struct

// MARK: - Preview
#Preview {
    StepTwoView()
        .preferredColorScheme(.dark)
}
