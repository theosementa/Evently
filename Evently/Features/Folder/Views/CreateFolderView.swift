//
//  CreateFolderView.swift
//  Evently
//
//  Created by Theo Sementa on 07/02/2025.
//

import SwiftUI
import NavigationKit

struct CreateFolderView: View {

    @Environment(\.dismiss) private var dismiss
    @State private var viewModel: CreateFolderViewModel = .init()
    @StateObject private var createFolderRouter = Router<NavigationDestination>()

    // MARK: -
    var body: some View {
        RoutedNavigationStack(router: createFolderRouter) {
            VStack(spacing: 16) {
                CreationHeader(
                    icon: .folder,
                    title: "create_folder_title".localized
                )

                ScrollView {
                    VStack(spacing: 24) {
                        CustomTextField(
                            text: $viewModel.name,
                            config: .init(
                                title: "create_folder_name_folder".localized,
                                placeholder: "create_folder_placeholder".localized
                            )
                        )

                        FriendsPicker(selectedFriends: $viewModel.selectedFriends)

                        if !viewModel.selectedFriends.isEmpty {
                            MemberListRow(members: viewModel.selectedFriends)
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
                        style: viewModel.name.isBlank ? .disabled : .default,
                        title: "global_finish".localized,
                        isFill: true
                    )
                ) {
                    viewModel.createFolder()
                    dismiss()
                }
                .padding(24)
            }
            .background(Color.black0)
            .ignoresSafeArea(.container, edges: .bottom)
        }
        .environmentObject(createFolderRouter)
    } // body
} // struct

// MARK: - Preview
#Preview {
    CreateFolderView()
}
