//
//  AddFriendView.swift
//  Evently
//
//  Created by Theo Sementa on 07/02/2025.
//

import SwiftUI

struct AddFriendView: View {
    
    @State private var friendUsername: String = ""
    
    // MARK: -
    var body: some View {
        VStack(spacing: 48) {
            CreationHeader(
                icon: .person,
                title: "global_add_friends".localized
            )
            
            CustomTextField(
                text: $friendUsername,
                config: .init(
                    title: "add_friends_username".localized,
                    placeholder: "myfriend#0001"
                )
            )
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .bottom) {
            ActionButton(
                config: .init(
                    style: !friendUsername.isBlank ? .default : .disabled,
                    title: "global_send".localized,
                    isFill: true
                )
            ) {
                
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
