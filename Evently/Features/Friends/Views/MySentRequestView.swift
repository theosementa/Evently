//
//  MySentRequestView.swift
//  Evently
//
//  Created by Theo Sementa on 14/02/2025.
//

import SwiftUI

struct MySentRequestView: View {

    @Environment(\.dismiss) private var dismiss
    @Environment(FriendStore.self) private var friendStore

    // MARK: -
    var body: some View {
        VStack(spacing: 16) {
            VStack(spacing: 16) {
                HStack {
                    TinyActionButton(icon: .chevronBack) { dismiss() }
                    Spacer()
                }

                HStack {
                    Image(.paperPlane)
                        .resizable()
                        .frame(width: 32, height: 32)
                    Text("my_friends_sent_requests".localized)
                        .font(.Headline.head4)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }

            ScrollView {
                VStack(spacing: 16) {
                    ForEach(friendStore.sentRequests) { request in
                        let receiver = request.receiver
                        HStack(spacing: 12) {
                            Image(.person)
                                .resizable()
                                .frame(width: 32, height: 32)

                            VStack(alignment: .leading, spacing: 0) {
                                Text(receiver?.fullName ?? "")
                                    .font(.Content.largeMedium)

                                Text(receiver?.username ?? "")
                                    .font(.Content.smallSemiBold)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }
            .scrollIndicators(.hidden)
            .contentMargins(.top, 32, for: .scrollContent)
            .refreshable {
                await friendStore.fetchSentRequests()
            }
        }
        .padding(24)
        .background(Color.black0)
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await friendStore.fetchSentRequests()
        }
    } // body
} // struct

// MARK: - Preview
#Preview {
    MySentRequestView()
}
