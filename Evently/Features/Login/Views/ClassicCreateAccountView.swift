//
//  ClassicCreateAccountView.swift
//  Evently
//
//  Created by Theo Sementa on 12/02/2025.
//

import SwiftUI

struct ClassicCreateAccountView: View {

    @State private var viewModel: ClassicLoginViewModel = .shared
    @Environment(UserStore.self) private var userStore
    @Environment(\.dismiss) private var dismiss

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
                        placeholder: "thomasdupont@gmail.com"
                    )
                )

                CustomTextField(
                    text: $viewModel.password,
                    config: .init(
                        title: "auth_password".localized,
                        placeholder: "Th@ma$12",
                        isSecured: true
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
                    style: .default,
                    icon: .sparkes,
                    title: "auth_create_account".localized,
                    isFill: true
                )
            ) {

            }

            Spacer()
        }
        .padding(24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black0)
    } // body
} // struct

// MARK: - Preview
#Preview {
    ClassicCreateAccountView()
        .preferredColorScheme(.dark)
        .environment(UserStore.shared)
}
