//
//  ProfileView.swift
//  Evently
//
//  Created by Theo Sementa on 07/02/2025.
//

import SwiftUI

struct ProfileView: View {

    @Environment(UserStore.self) private var userStore
    @Environment(FriendStore.self) private var friendStore

    // MARK: -
    var body: some View {
        VStack(spacing: 16) {
            if let currentUser = userStore.currentUser {
                Text("Hello, \(currentUser.fullName)!")
                Text(currentUser.username ?? "")
            }
            ForEach(friendStore.friends) { friend in
                Text(friend.fullName)
            }
        }
    } // body
} // struct

// MARK: - Preview
#Preview {
    ProfileView()
}
