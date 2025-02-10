//
//  LoginView.swift
//  Evently
//
//  Created by Theo Sementa on 04/02/2025.
//

import SwiftUI
import NavigationKit

struct LoginView: View {

    var router: Router<NavigationDestination>

    private let signInWithAppleManager: SignInWithAppleManager
    private let signInWithGoogleManager: SignInWithGoogleManager

    init(router: Router<NavigationDestination>) {
        self.router = router
        self.signInWithAppleManager = SignInWithAppleManager(router: router)
        self.signInWithGoogleManager = SignInWithGoogleManager(router: router)
    }

    // MARK: -
    var body: some View {
        VStack(spacing: 32) {
            VStack(alignment: .leading, spacing: 32) {
                HStack(spacing: 16) {
                    Image(.logoEvently)
                        .resizable()
                        .frame(width: 40, height: 40)
                        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    Text("Evently")
                        .font(.Headline.head3)

                    Spacer()
                }

                Text("auth_dont_miss".localized)
                    .font(.Content.largeMedium)

                Text("auth_desc".localized)
                    .font(.Content.largeMedium)
            }

            Rectangle()
                .frame(height: 1)
                .foregroundStyle(Color.black200)

            VStack(spacing: 16) {
                ActionButtonReversed(
                    config: .init(
                        style: .reversed,
                        icon: .apple,
                        title: "auth_with_apple".localized,
                        isTextFill: true
                    )
                ) { signInWithAppleManager.performSignIn() }

                ActionButtonReversed(
                    config: .init(
                        style: .google,
                        icon: .google,
                        title: "auth_with_google".localized,
                        isTextFill: true
                    )
                ) { signInWithGoogleManager.signIn() }

                ActionButtonReversed(
                    config: .init(
                        style: .secondaryReversed,
                        icon: .person,
                        title: "auth_classic".localized,
                        isTextFill: true
                    )
                ) { router.pushClassicLogin() }
            }
        }
        .padding(24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black0)
    } // body
} // struct

// MARK: - Preview
#Preview {
    LoginView(router: .init())
        .preferredColorScheme(.dark)
}
