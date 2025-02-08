//
//  FriendRow.swift
//  Evently
//
//  Created by Theo Sementa on 08/02/2025.
//

import SwiftUI

struct FriendRow: View {

    // builder
    var friend: UserModel

    @Environment(FriendStore.self) private var friendStore

    // MARK: -
    var body: some View {
        HStack(spacing: 16) {
            HStack(spacing: 12) {
                Image(.person)
                    .resizable()
                    .frame(width: 32, height: 32)

                VStack(alignment: .leading, spacing: 0) {
                    Text(friend.fullName)
                        .font(.Content.largeMedium)

                    Text(friend.username ?? "")
                        .font(.Content.smallSemiBold)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            AsyncButton {
                // TODO: display an alert
//                await friendStore.deleteFriend(user: friend)
            } label: {
                Image(.trash)
                    .renderingMode(.template)
                    .foregroundStyle(Color.red)
            }
        }
    } // body
} // struct

// MARK: - Preview
#Preview {
    FriendRow(friend: .preview)
        .padding()
        .background(Color.black0)
        .preferredColorScheme(.dark)
        .environment(FriendStore.shared)
}
