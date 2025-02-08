//
//  MyFriendRequestsView.swift
//  Evently
//
//  Created by Theo Sementa on 08/02/2025.
//

import SwiftUI

struct MyFriendRequestsView: View {

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
                    Image(.person)
                        .resizable()
                        .frame(width: 32, height: 32)
                    Text("Demandes reçu".localized) // TODO: TBL
                        .font(.Headline.head4)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }

            ScrollView {
                VStack(spacing: 16) {
                    ForEach(friendStore.requests) { request in
                        FriendRequestRow(friendRequest: request)
                    }
                }
            }
            .scrollIndicators(.hidden)
            .contentMargins(.top, 32, for: .scrollContent)
            .refreshable {
                await friendStore.fetchRequests()
            }
        }
        .padding(24)
        .background(Color.black0)
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await friendStore.fetchRequests()
        }
    } // body
} // struct

// MARK: - Preview
#Preview {
    MyFriendRequestsView()
}
