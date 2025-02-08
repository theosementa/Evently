//
//  FriendRequestRow.swift
//  Evently
//
//  Created by Theo Sementa on 08/02/2025.
//

import SwiftUI

struct FriendRequestRow: View {

    // builder
    var friendRequest: FriendRequestModel
    @Environment(FriendStore.self) private var friendStore

    // MARK: -
    var body: some View {
        let asker = friendRequest.asker
        VStack(spacing: 16) {
            HStack(spacing: 12) {
                Image(.person)
                    .resizable()
                    .frame(width: 32, height: 32)

                VStack(alignment: .leading, spacing: 0) {
                    Text(asker?.fullName ?? "")
                        .font(.Content.largeMedium)

                    Text(asker?.username ?? "")
                        .font(.Content.smallSemiBold)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            HStack(spacing: 16) {
                ActionButton(
                    config: .init(
                        style: .small,
                        icon: .checkmarkCircle,
                        title: "Accepter", // TODO: TBL
                        isFill: true
                    )
                ) {
                    if let requestID = friendRequest.id {
                        await friendStore.answerRequest(requestID: requestID, answer: true)
                    }
                }

                ActionButton(
                    config: .init(
                        style: .smallSecondary,
                        icon: .xmark,
                        title: "Refuser", // TODO: TBL
                        isFill: true
                    )
                ) {
                    if let requestID = friendRequest.id {
                        await friendStore.answerRequest(requestID: requestID, answer: false)
                    }
                }
            }
        }
    } // body
} // struct

// MARK: - Preview
#Preview {
    FriendRequestRow(
        friendRequest: .init(
            id: 1,
            asker: .preview,
            receiver: .preview
        )
    )
}
