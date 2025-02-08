//
//  CreateFolderView.swift
//  Evently
//
//  Created by Theo Sementa on 07/02/2025.
//

import SwiftUI

struct CreateFolderView: View {

    @State private var name: String = ""
    @State private var selectedFriends: [UserModel] = []

    // MARK: -
    var body: some View {
        VStack(spacing: 16) {
            CreationHeader(
                icon: .folder,
                title: "create_folder_title".localized
            )

            ScrollView {
                VStack(spacing: 24) {
                    CustomTextField(
                        text: $name,
                        config: .init(
                            title: "create_folder_name_folder".localized,
                            placeholder: "create_folder_placeholder".localized
                        )
                    )

                    FriendsPicker(selectedFriends: $selectedFriends)
                    
                    if !selectedFriends.isEmpty {
                        MemberListRow(members: selectedFriends)
                    }
                }
                .padding(.horizontal, 1)
            }
            .scrollIndicators(.hidden)
            .contentMargins(.top, 32, for: .scrollContent)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .bottom) {
            ActionButton(
                config: .init(
                    style: .disabled,
                    title: "global_finish".localized,
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
    CreateFolderView()
}
