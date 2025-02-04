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

    init(router: Router<NavigationDestination>) {
        self.router = router
        self.signInWithAppleManager = SignInWithAppleManager(router: router)
    }

    // MARK: -
    var body: some View {
        VStack(spacing: 32) {
            VStack(spacing: 32) {
                HStack {
                    Image(.logoEvently)
                        .resizable()
                        .frame(width: 40, height: 40)
                        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    Text("Evently")
                        .font(.Headline.head4)

                    Spacer()
                }
                // TODO: TBL
                Text("""
Ne rate plus aucun événement, jamais.

Dès maintenant, laisse-nous gérer l’organisation pendant que tu te concentres sur l’essentiel
""")
                .font(.Content.largeMedium)
            }

            Rectangle()
                .frame(height: 1)
                .foregroundStyle(Color.black200)

            ActionButton(
                style: .reversed,
                icon: .apple,
                title: "Se connecter avec Apple",
                isFill: true
            ) {
                signInWithAppleManager.performSignIn()
            }
        }
        .padding(24)
        .background(Color.black0)
    } // body
} // struct

// MARK: - Preview
#Preview {
    LoginView(router: .init())
        .preferredColorScheme(.dark)
}
