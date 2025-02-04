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
            VStack(spacing: 32) {
                HStack(spacing: 16) {
                    Image(.logoEvently)
                        .resizable()
                        .frame(width: 40, height: 40)
                        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    Text("Evently")
                        .font(.Headline.head3)

                    Spacer()
                }
                // TODO: TBL
                Text("""
Ne manque plus aucun événement !

Gère ton planning en toute simplicité et garde le contrôle sur tous tes événements.
""")
                .font(.Content.largeMedium)
            }

            Rectangle()
                .frame(height: 1)
                .foregroundStyle(Color.black200)

            VStack(spacing: 16) {
                ActionButton(
                    style: .reversed,
                    icon: .apple,
                    title: "Se connecter avec Apple",
                    isFill: true
                ) {
                    signInWithAppleManager.performSignIn()
                }

                ActionButton(
                    style: .google,
                    icon: .google,
                    title: "Se connecter avec Google",
                    isFill: true
                ) {
                    signInWithAppleManager.performSignIn()
                }

                ActionButton(
                    style: .secondaryReversed,
                    icon: .person,
                    title: "Connexion classique",
                    isFill: true
                ) {

                }
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
