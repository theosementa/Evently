//
//  ProfileView.swift
//  Evently
//
//  Created by Theo Sementa on 07/02/2025.
//

import SwiftUI

struct ProfileView: View {

    @Environment(\.dismiss) private var dismiss

    @Environment(UserStore.self) private var userStore

    // MARK: -
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                TinyActionButton(icon: .chevronBack) { dismiss() }
                Spacer()
            }

            ScrollView {
                VStack(spacing: 48) {
                    if let currentUser = userStore.currentUser {
                        VStack(spacing: 8) {
                            Text(currentUser.fullName)
                                .font(.Headline.head4)
                            Button(action: {
                                UIPasteboard.general.string = currentUser.username ?? ""
                                BannerManager.shared.banner = Banner.usernameCopied
                            }, label: {
                                HStack(spacing: 8) {
                                    Image(.copy)
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                    Text(currentUser.username ?? "")
                                        .font(.Content.largeSemiBold)
                                }
                            })
                        }
                        .foregroundStyle(Color.white0)
                    }

                    VStack(spacing: 16) {
                        ProfileRow(
                            icon: .person,
                            title: "Mes amis",
                            isPushable: true
                        ) // TODO: TBL
                        ProfileRow(
                            icon: .hammer,
                            title: "Mes préférences",
                            isPushable: true
                        ) // TODO: TBL
                        ProfileRow(
                            icon: .gear,
                            title: "Gérer mon compte",
                            isPushable: true
                        ) // TODO: TBL
                    }
                    .padding(.horizontal, 1)

                }
            } // ScrollView
            .scrollIndicators(.hidden)
        }
        .padding(24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black0)
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
    } // body
} // struct

// MARK: - Preview
#Preview {
    ProfileView()
}
