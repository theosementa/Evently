//
//  SideMenuView.swift
//  POC_SideMenu
//
//  Created by Theo Sementa on 04/02/2025.
//

import SwiftUI
import NavigationKit

struct SideMenuView: View {

    @Environment(\.safeAreaInsets) private var safeAreaInsets

    @Environment(FolderStore.self) private var folderStore
    @Environment(CategoryStore.self) private var categoryStore
    @Environment(AppManager.self) private var appManager

    @EnvironmentObject private var router: Router<NavigationDestination>

    // MARK: -
    var body: some View {
        HStack {
            Spacer()

            ScrollView {
                VStack(alignment: .trailing, spacing: 32) {
                    VStack(alignment: .leading, spacing: 8) {
                        ActionButton(
                            config: .init(
                                style: appManager.sideMenuItem == .events ? .default : .unselectedSideBar,
                                icon: .sparkes,
                                title: "sidebar_my_events".localized,
                                isFill: true,
                                alignment: .leading
                            )
                        ) { appManager.sideMenuItem = .events }

                        ActionButton(
                            config: .init(
                                style: appManager.sideMenuItem == .calendar ? .default : .unselectedSideBar,
                                icon: .calendar,
                                title: "sidebar_my_calendar".localized,
                                isFill: true,
                                alignment: .leading
                            )
                        ) { appManager.sideMenuItem = .calendar }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)

                    Separator()

                    VStack(alignment: .leading, spacing: 8) {
                        ActionButton(
                            config: .init(
                                style: .unselectedSideBar,
                                icon: .folderPlus,
                                title: "sidebar_add_folder".localized,
                                isFill: true,
                                alignment: .leading
                            )
                        ) {
                            appManager.isSideMenuPresented = false
                            router.presentCreateFolder()
                        }

                        ActionButton(
                            config: .init(
                                style: .unselectedSideBar,
                                icon: .plusCircle,
                                title: "sidebar_add_category".localized,
                                isFill: true,
                                alignment: .leading
                            )
                        ) {
                            appManager.isSideMenuPresented = false
                            router.presentCreateCategory()
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)

                    if !folderStore.folders.isEmpty {
                        Separator()

                        VStack(alignment: .leading, spacing: 8) {
                            ForEach(folderStore.folders) { folder in
                                ActionButton(
                                    config: .init(
                                        style: appManager.sideMenuItem == .folder(id: folder.id)
                                        ? .default
                                        : .unselectedSideBar,
                                        icon: .folder,
                                        title: folder.name,
                                        isFill: true,
                                        alignment: .leading
                                    )
                                ) { appManager.sideMenuItem = .folder(id: folder.id) }
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }

                    if !categoryStore.allCategories.isEmpty {
                        Separator()

                        VStack(alignment: .leading, spacing: 8) {
                            ForEach(categoryStore.allCategories) { category in
                                ActionButton(
                                    config: .init(
                                        style: appManager.sideMenuItem == .category(id: category.id)
                                        ? .default
                                        : .unselectedSideBar,
                                        icon: ImageResource(name: category.icon, bundle: .main),
                                        title: category.name,
                                        isFill: true,
                                        alignment: .leading,
                                        customBackground: AnyShapeStyle(category.gradient)
                                    )
                                ) { appManager.sideMenuItem = .category(id: category.id) }
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }

                }
                .padding()
                .padding(.top, safeAreaInsets.top)
                .padding(.bottom, safeAreaInsets.bottom)
            }
            .scrollIndicators(.hidden)
            .fixedSize(horizontal: true, vertical: false)
            .background(Color.black100)
        }
        .background(.clear)
    } // body
} // struct
