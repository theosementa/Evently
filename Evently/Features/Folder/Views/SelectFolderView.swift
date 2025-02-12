//
//  SelectFolderView.swift
//  Evently
//
//  Created by Theo Sementa on 07/02/2025.
//

import SwiftUI
import NavigationKit

struct SelectFolderView: View {

    @Binding var selectedFolder: FolderModel?

    @Environment(\.dismiss) private var dismiss
    @Environment(FolderStore.self) private var folderStore
    @StateObject private var selectFolderRouter = Router<NavigationDestination>()

    @State private var searchText: String = ""

    // MARK: -
    var body: some View {
        RoutedNavigationStack(router: selectFolderRouter) {
            VStack(spacing: 32) {
                VStack(spacing: 24) {
                    CreationHeader(
                        icon: .folder,
                        title: "add_folder_title".localized
                    )
                    CustomSearchBar(
                        text: $searchText,
                        placeholder: "add_folder_search_placeholder".localized
                    )
                }

                ScrollView {
                    VStack(spacing: 32) {
                        Separator()

                        VStack(spacing: 8) {
                            Text("add_folder_can_create".localized)
                                .font(.Content.mediumSemiBold)
                            ActionButton(
                                config: .init(
                                    style: .default,
                                    icon: .plusCircle,
                                    title: "create_folder_title".localized,
                                    isFill: true
                                )
                            ) {
                                selectFolderRouter.presentCreateFolder()
                            }
                        }

                        Separator()

                        VStack(spacing: 16) {
                            ForEach(folderStore.folders) { folder in
                                ActionButton(
                                    config: .init(
                                        style: selectedFolder == folder ? .default : .unselected,
                                        icon: .folder,
                                        title: folder.name,
                                        isFill: true,
                                        alignment: .leading
                                    )
                                ) {
                                    if selectedFolder == folder {
                                        selectedFolder = nil
                                    } else {
                                        selectedFolder = folder
                                        dismiss()
                                    }
                                }
                            }
                        }
                    }
                }
                .scrollIndicators(.hidden)
                .contentMargins(.bottom, 32, for: .scrollContent)
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black0)
            .ignoresSafeArea(.container, edges: .bottom)
        }
    } // body
} // struct

// MARK: - Preview
#Preview {
    SelectFolderView(selectedFolder: .constant(.preview))
}
