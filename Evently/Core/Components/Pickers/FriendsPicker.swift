//
//  FriendsPicker.swift
//  Evently
//
//  Created by Theo Sementa on 07/02/2025.
//

import SwiftUI
import NavigationKit

struct FriendsPicker: View {

    // builder
    @Binding var selectedFriends: [UserModel]

    @EnvironmentObject private var router: Router<NavigationDestination>

    // MARK: -
    var body: some View {
        VStack(spacing: 6) {
            Text("global_friends".localized)
                .font(.Content.smallSemiBold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 8)

                ActionButton(
                    config: .init(
                        style: .default,
                        icon: .plusCircle,
                        title: "global_add_friends".localized,
                        isFill: true
                    )
                ) {
                    router.presentSelectedFriends(selectedFriends: $selectedFriends)
                }
        }
    } // body
} // struct

// MARK: - Preview
#Preview {
    FriendsPicker(selectedFriends: .constant([.preview]))
}
