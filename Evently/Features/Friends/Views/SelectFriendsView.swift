//
//  SelectFriendsView.swift
//  Evently
//
//  Created by Theo Sementa on 07/02/2025.
//

import SwiftUI

struct SelectFriendsView: View {

    // builder
    @Binding var selectedFriends: [UserModel]

    @Environment(\.dismiss) private var dismiss
    @Environment(FriendStore.self) private var friendStore

    @State private var searchText: String = ""
    @State private var localSelectedFriends: [UserModel] = []

    // MARK: -
    var body: some View {
        VStack(spacing: 32) {
            VStack(spacing: 24) {
                CreationHeader(
                    icon: .person,
                    title: "global_add_friends".localized
                )
                CustomSearchBar(
                    text: $searchText,
                    placeholder: "global_search_friend".localized
                )
            }

            ScrollView {
                VStack(spacing: 32) {
                    Separator()

                    VStack(spacing: 8) {
                        Text("add_friends_can_create".localized)
                            .font(.Content.mediumSemiBold)
                        ActionButton(
                            config: .init(
                                style: .default,
                                icon: .plusCircle,
                                title: "add_friends_label".localized,
                                isFill: true
                            )
                        ) { }
                    }

                    Separator()

                    VStack(spacing: 16) {
                        ForEach(friendStore.friends) { friend in
                            FriendsSelectionRow(
                                friends: $localSelectedFriends,
                                friend: friend
                            )
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
            .contentMargins(.bottom, 32, for: .scrollContent)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .bottom) {
            ActionButton(
                config: .init(
                    style: .default,
                    title: "global_finish".localized,
                    isFill: true
                )
            ) {
                selectedFriends = localSelectedFriends
                dismiss()
            }
            .padding(24)
        }
        .background(Color.black0)
        .ignoresSafeArea(.container, edges: .bottom)
        .onAppear {
            localSelectedFriends = selectedFriends
        }
    } // body
} // struct

// MARK: - Preview
#Preview {
    SelectFriendsView(selectedFriends: .constant([]))
}
