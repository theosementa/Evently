//
//  StepTwoView.swift
//  Evently
//
//  Created by Theo Sementa on 04/02/2025.
//

import SwiftUI

struct StepTwoView: View {

    @State private var viewModel: LoginViewModel = .shared

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
            ) { await viewModel.stepTwo() }
        }
        .padding(24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black0)
    } // body
} // struct

// MARK: - Preview
#Preview {
    StepTwoView()
        .preferredColorScheme(.dark)
}
