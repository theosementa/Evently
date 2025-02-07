//
//  FolderPicker.swift
//  Evently
//
//  Created by Theo Sementa on 07/02/2025.
//

import SwiftUI
import NavigationKit

struct FolderPicker: View {

    @Binding var selectedFolder: FolderModel?

    @EnvironmentObject private var router: Router<NavigationDestination>

    // MARK: -
    var body: some View {
        VStack(spacing: 6) {
            Text("add_event_folder_shared".localized)
                .font(.Content.smallSemiBold)
                .frame(maxWidth: .infinity, alignment: .leading)

                ActionButton(
                    config: .init(
                        style: .default,
                        icon: .folderPlus,
                        title: "add_event_choose_folder".localized,
                        isFill: true
                    )
                ) {
                    router.presentSelectFolder(selectedFolder: $selectedFolder)
                }
        }
    } // body
} // struct

// MARK: - Preview
#Preview {
    FolderPicker(selectedFolder: .constant(.preview))
}
