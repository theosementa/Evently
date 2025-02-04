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
                Text("Il nous manque plus que ton nom et prénom pour finaliser ton inscription") // TODO: TBL
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(Color.black200)
                TextField("Nom", text: $viewModel.lastName)
                TextField("Prénom", text: $viewModel.firstName)
            }

            ActionButton(
                style: .default,
                icon: .sparkes,
                title: "Terminer l'inscription",
                isFill: true
            ) {
                Task {
                    await viewModel.stepTwo()
                }
            }
        }
    } // body
} // struct

// MARK: - Preview
#Preview {
    StepTwoView()
}
