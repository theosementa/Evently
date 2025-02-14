//
//  ManageMyAccountView.swift
//  Evently
//
//  Created by Theo Sementa on 14/02/2025.
//

import SwiftUI

struct ManageMyAccountView: View {

    @Environment(\.dismiss) private var dismiss
    @Environment(UserStore.self) private var userStore

    // MARK: -
    var body: some View {
        VStack(spacing: 16) {
            VStack(spacing: 16) {
                HStack {
                    TinyActionButton(icon: .chevronBack) { dismiss() }
                    Spacer()
                }

                HStack {
                    Image(.gear)
                        .resizable()
                        .frame(width: 32, height: 32)
                    Text("profile_manage_my_account".localized)
                        .font(.Headline.head4)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }

            ScrollView {
                VStack(spacing: 16) {
                    ActionButton(
                        config: .init(
                            style: .default,
                            icon: .logout,
                            title: "account_logout".localized,
                            isFill: true,
                            alignment: .leading
                        )
                    ) {
                        // TODO: Add alert
                        //await userStore.logout()
                    }

                    ActionButton(
                        config: .init(
                            style: .default,
                            icon: .trash,
                            title: "account_delete".localized,
                            isFill: true,
                            alignment: .leading,
                            customBackground: AnyShapeStyle(LinearGradient.redGradient)
                        )
                    ) {
                        // TODO: Add alert
                        // await userStore.deleteMyAccount()
                    }
                }
            }
            .scrollIndicators(.hidden)
            .contentMargins(.top, 32, for: .scrollContent)
        }
        .padding(24)
        .background(Color.black0)
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
    } // body
} // struct

// MARK: - Preview
#Preview {
    ManageMyAccountView()
}
