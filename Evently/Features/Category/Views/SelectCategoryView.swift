//
//  SelectCategoryView.swift
//  Evently
//
//  Created by Theo Sementa on 05/02/2025.
//

import SwiftUI
import NavigationKit

struct SelectCategoryView: View {

    @Binding var selectedCategory: CategoryModel?

    @Environment(\.dismiss) private var dismiss
    @Environment(CategoryStore.self) private var categoryStore
    @StateObject private var selectCategoryRouter = Router<NavigationDestination>()

    @State private var searchText: String = ""

    // MARK: -
    var body: some View {
        RoutedNavigationStack(router: selectCategoryRouter) {
            VStack(spacing: 32) {
                VStack(spacing: 24) {
                    CreationHeader(
                        icon: .tag,
                        title: "add_category_title".localized
                    )
                    CustomSearchBar(text: $searchText)
                }

                ScrollView {
                    VStack(spacing: 32) {
                        Separator()

                        VStack(spacing: 8) {
                            Text("add_category_can_create".localized)
                                .font(.Content.mediumSemiBold)
                            ActionButton(
                                config: .init(
                                    style: .default,
                                    icon: .plusCircle,
                                    title: "sidebar_add_category".localized,
                                    isFill: true
                                )
                            ) { selectCategoryRouter.presentCreateCategory() }
                        }

                        Separator()

                        VStack(spacing: 16) {
                            ForEach(categoryStore.allCategories) { category in
                                ActionButton(
                                    config: .init(
                                        style: .default,
                                        icon: ImageResource(name: category.icon, bundle: .main),
                                        title: category.name,
                                        isFill: true,
                                        alignment: .leading,
                                        customBackground: AnyShapeStyle(category.gradient)
                                    )
                                ) {
                                    selectedCategory = category
                                    dismiss()
                                }
                                .overlay {
                                    if selectedCategory?.id == category.id {
                                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                                            .stroke(Color.white0, lineWidth: 2)
                                            .padding(.horizontal, 1)
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
    SelectCategoryView(selectedCategory: .constant(nil))
        .preferredColorScheme(.dark)
        .environment(CategoryStore.shared)
}
