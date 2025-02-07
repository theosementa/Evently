//
//  FriendsSelectionRow.swift
//  Evently
//
//  Created by Theo Sementa on 07/02/2025.
//

import SwiftUI

struct FriendsSelectionRow: View {

    // builder
    @Binding var friends: [UserModel]
    var friend: UserModel

    var isAdded: Bool {
        return friends.contains(where: { $0.id == friend.id })
    }

    // MARK: -
    var body: some View {
        HStack(spacing: 16) {
            HStack(spacing: 8) {
                Image(.person)
                Text(friend.fullName)
                    .font(.Content.largeSemiBold)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            Button {
                if isAdded {
                    friends.removeAll(where: { $0.id == friend.id })
                } else {
                    friends.append(friend)
                }
            } label: {
                HStack(spacing: 8) {
                    if isAdded {
                        Image(.iconCheckmark)
                            .renderingMode(.template)
                    }
                    Text(isAdded ? "global_added".localized : "global_add".localized)
                        .font(.Content.mediumBold)
                }
                .foregroundStyle(isAdded ? Color.black100 : Color.white0)
                .padding(.horizontal, 14)
                .padding(.top, 6)
                .background {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(isAdded ? Color.white0 : Color.black200)
                }
            }
        }
    } // body
} // struct

// MARK: - Preview
#Preview {
    FriendsSelectionRow(
        friends: .constant([.preview]),
        friend: .preview
    )
}
