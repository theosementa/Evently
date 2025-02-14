//
//  ClassicCreateAccountView.swift
//  Evently
//
//  Created by Theo Sementa on 12/02/2025.
//

import SwiftUI
import NavigationKit

struct ClassicCreateAccountView: View {

    @State private var viewModel: ClassicLoginViewModel = .shared
    @Environment(UserStore.self) private var userStore
    @Environment(\.dismiss) private var dismiss

    @EnvironmentObject var router: Router<NavigationDestination>

    // MARK: -
    var body: some View {
        VStack(spacing: 48) {
            HStack {
                TinyActionButton(icon: .chevronBack) { dismiss() }
                Spacer()
            }

            Spacer()

            VStack(spacing: 32) {
                CustomTextField(
                    text: $viewModel.email,
                    config: .init(
                        title: "auth_email".localized,
                        placeholder: "thomasdupont@gmail.com",
                        rules: [
                            .init(
                                isActive: viewModel.isEmailAvailable && viewModel.email ~= Regex.email,
                                text: "Email disponible" // TODO: TBL
                            )
                        ]
                    )
                )

                CustomTextField(
                    text: $viewModel.password,
                    config: .init(
                        title: "auth_password".localized,
                        placeholder: "Th@ma$12",
                        isSecured: true,
                        rules: [
                            .init(
                                isActive: viewModel.password ~= Regex.moreThan8,
                                text: "8 caractères"
                            ), // TODO: TBL
                            .init(
                                isActive: viewModel.password ~= Regex.startPassword,
                                text: "Majuscule, minuscule et chiffre"
                            ) // TODO: TBL
                        ]
                    )
                )

                CustomTextField(
                    text: $viewModel.confirmPassword,
                    config: .init(
                        title: "auth_confirm_password".localized,
                        placeholder: "Th@ma$12",
                        isSecured: true
                    )
                )
            }

            ActionButton(
                config: .init(
                    style: viewModel.isReadyToCreateAnAccount() ? .default : .disabled,
                    icon: .sparkes,
                    title: "auth_create_account".localized,
                    isFill: true
                )
            ) {
                viewModel.isInStepTwo = true
                router.pushStepTwo()
            }

            Spacer()
        }
        .padding(24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black0)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .onChange(of: viewModel.email) {
            Task {
                viewModel.isEmailAvailable = await UserStore.shared.isEmailAvailable(viewModel.email)
            }
        }
    } // body
} // struct

// MARK: - Preview
#Preview {
    ClassicCreateAccountView()
        .preferredColorScheme(.dark)
        .environment(UserStore.shared)
}
