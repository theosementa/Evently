//
//  ClassicLoginView.swift
//  Evently
//
//  Created by Theo Sementa on 05/02/2025.
//

import SwiftUI

struct ClassicLoginView: View {

    @State private var viewModel: ClassicLoginViewModel = .init()
    @Environment(UserStore.self) private var userStore

    // MARK: -
    var body: some View {
        VStack(spacing: 48) {
            VStack(spacing: 32) {
                Text("auth_classic_desc".localized)
                    .font(.Content.largeMedium)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Separator()

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
                    style: .default,
                    icon: .sparkes,
                    title: "auth_connection".localized,
                    isFill: true
                )
            ) {

            }
        }
        .padding(24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black0)
    } // body
} // struct

// MARK: - Preview
#Preview {
    ClassicLoginView()
        .preferredColorScheme(.dark)
}
