//
//  ProfileView.swift
//  Evently
//
//  Created by Theo Sementa on 07/02/2025.
//

import SwiftUI
import NavigationKit

struct ProfileView: View {

    @Environment(\.dismiss) private var dismiss
    @Environment(\.openURL) private var openURL

    @EnvironmentObject private var router: Router<NavigationDestination>
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
                        RoutedNavigationButton(push: router.pushMyFriends()) {
                            ProfileRow(
                                icon: .person,
                                title: "profile_my_friends".localized,
                                isPushable: true
                            )
                        }
                        ProfileRow(
                            icon: .hammer,
                            title: "profile_my_preferences".localized,
                            isPushable: true
                        )
                        ProfileRow(
                            icon: .gear,
                            title: "profile_manage_my_account".localized,
                            isPushable: true
                        )
                    }
                    .padding(.horizontal, 1)

                    VStack(spacing: 16) {
                        ProfileRow(
                            icon: .share,
                            title: "profile_share".localized,
                            isPushable: false
                        )
                        ProfileRow(
                            icon: .star,
                            title: "profile_review".localized,
                            isPushable: false
                        )
                        Button {
                            if let url = URL(string: "mailto:contact@evently-app.fr") {
                                openURL(url)
                            }
                        } label: {
                            ProfileRow(
                                icon: .mail,
                                title: "profile_contact".localized,
                                isPushable: false
                            )
                        }

                    }
                    .padding(.horizontal, 1)
                }
            } // ScrollView
            .scrollIndicators(.hidden)
            .contentMargins(.top, 32, for: .scrollContent)
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
        .environment(UserStore.shared)
}
