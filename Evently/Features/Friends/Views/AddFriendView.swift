//
//  AddFriendView.swift
//  Evently
//
//  Created by Theo Sementa on 07/02/2025.
//

import SwiftUI

struct AddFriendView: View {

   @State private var viewModel: AddFriendViewModel = .init()

    @Environment(\.dismiss) private var dismiss

    // MARK: -
    var body: some View {
        VStack(spacing: 48) {
            CreationHeader(
                icon: .person,
                title: "global_add_friends".localized
            )

            CustomTextField(
                text: $viewModel.friendUsername,
                config: .init(
                    title: "add_friends_username".localized,
                    placeholder: "myfriend#0001"
                )
            )
            .textInputAutocapitalization(.never)

            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .bottom) {
            ActionButton(
                config: .init(
                    style: !viewModel.friendUsername.isBlank ? .default : .disabled,
                    title: "global_send".localized,
                    isFill: true
                )
            ) {
                if await FriendStore.shared.sendRequest(username: viewModel.friendUsername) {
                    dismiss()
                }
            }
            .padding(24)
        }
        .background(Color.black0)
        .ignoresSafeArea(.container, edges: .bottom)
    } // body
} // struct

// MARK: - Preview
#Preview {
    AddFriendView()
}
