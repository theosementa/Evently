//
//  MyFriendsView.swift
//  Evently
//
//  Created by Theo Sementa on 08/02/2025.
//

import SwiftUI
import NavigationKit

struct MyFriendsView: View {

    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var router: Router<NavigationDestination>
    @Environment(FriendStore.self) private var friendStore

    // MARK: -
    var body: some View {
        VStack(spacing: 16) {
            VStack(spacing: 16) {
                HStack {
                    TinyActionButton(icon: .chevronBack) { dismiss() }
                    Spacer()
                    TinyActionButton(icon: .plusCircle) {
                        router.presentAddFriend()
                    }
                }

                HStack {
                    Image(.person)
                        .resizable()
                        .frame(width: 32, height: 32)
                    Text("profile_my_friends".localized)
                        .font(.Headline.head4)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }

            ScrollView {
                VStack(spacing: 48) {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("my_friends_requests".localized)
                            .font(.Content.xlSemiBold)

                        HStack(spacing: 16) {
                            ActionButton(
                                config: .init(
                                    style: .default,
                                    icon: .paperPlane,
                                    title: "global_sent".localized,
                                    isFill: true
                                )
                            ) { }
                            ActionButton(
                                config: .init(
                                    style: .default,
                                    icon: .inbox,
                                    title: "global_received".localized,
                                    isFill: true
                                )
                            ) { router.pushMyFriendRequests() }
                        }
                    }

                    VStack(alignment: .leading, spacing: 16) {
                        ForEach(friendStore.requests) { request in
                            Text(request.asker?.fullName ?? "")
                                .onTapGesture {
                                    Task {
                                        if let requestID = request.id {
                                            await FriendStore.shared.answerRequest(requestID: requestID, answer: true)
                                        }
                                    }
                                }
                        }
                    }

                    VStack(alignment: .leading, spacing: 16) {
                        ForEach(friendStore.friends) { friend in
                            FriendRow(friend: friend)
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
            .contentMargins(.top, 32, for: .scrollContent)
            .refreshable {
                await friendStore.fetchFriends()
            }
        }
        .padding(24)
        .background(Color.black0)
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
    } // body
} // struct

// MARK: - Preview
#Preview {
    MyFriendsView()
        .preferredColorScheme(.dark)
        .environment(FriendStore.shared)
}
