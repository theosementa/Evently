//
//  ClassicLoginView.swift
//  Evently
//
//  Created by Theo Sementa on 05/02/2025.
//

import SwiftUI
import NavigationKit

struct ClassicLoginView: View {

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
            }

            ActionButton(
                config: .init(
                    style: (viewModel.email.isEmpty || viewModel.password.isEmpty) ? .disabled : .default,
                    icon: .sparkes,
                    title: "auth_connection".localized,
                    isFill: true
                )
            ) {
                if !viewModel.email.isEmpty && !viewModel.password.isEmpty {
                    await viewModel.loginWithCredentials()
                }
            }

            Separator()

            VStack(spacing: 16) {
                Text("auth_new_evently".localized)
                    .font(.Content.mediumBold)

                ActionButton(
                    config: .init(
                        style: .secondary,
                        icon: .sparkes,
                        title: "auth_create_account".localized,
                        isFill: true
                    )
                ) { router.pushClassicCreateAccount() }
            }

            Spacer()
        }
        .padding(24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black0)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            viewModel.resetData()
        }
    } // body
} // struct

// MARK: - Preview
#Preview {
    ClassicLoginView()
        .preferredColorScheme(.dark)
        .environment(UserStore.shared)
}
