//
//  CategoryPicker.swift
//  Evently
//
//  Created by Theo Sementa on 05/02/2025.
//

import SwiftUI
import NavigationKit

struct CategoryPicker: View {

    @Binding var selectedCategory: CategoryModel?

    @EnvironmentObject private var router: Router<NavigationDestination>

    // MARK: -
    var body: some View {
        VStack(spacing: 6) {
            Text("add_event_category".localized)
                .font(.Content.smallSemiBold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 8)

            if let selectedCategory {
                ActionButton(
                    config: .init(
                        style: .default,
                        icon: ImageResource(name: selectedCategory.icon, bundle: .main),
                        title: selectedCategory.name,
                        isFill: true,
                        customBackground: AnyShapeStyle(selectedCategory.gradient)
                    )
                ) {
                    router.presentSelectCategory(selectedCategory: $selectedCategory)
                }
            } else {
                ActionButton(
                    config: .init(
                        style: .default,
                        icon: .plusCircle,
                        title: "add_event_choose_category".localized,
                        isFill: true
                    )
                ) {
                    router.presentSelectCategory(selectedCategory: $selectedCategory)
                }
            }
        }
    } // body
} // struct

// MARK: - Preview
#Preview {
    CategoryPicker(selectedCategory: .constant(nil))
        .padding()
        .background(Color.black0)
        .preferredColorScheme(.dark)
}
