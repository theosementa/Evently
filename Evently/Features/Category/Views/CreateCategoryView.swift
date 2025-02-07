//
//  CreateCategoryView.swift
//  Evently
//
//  Created by Theo Sementa on 07/02/2025.
//

import SwiftUI

struct CreateCategoryView: View {

    @State private var name: String = ""

    // MARK: -
    var body: some View {
        VStack(spacing: 16) {
            CreationHeader(
                icon: .tag,
                title: "create_cat_title".localized
            )

            ScrollView {
                VStack(spacing: 24) {
                    CustomTextField(
                        text: $name,
                        config: .init(
                            title: "create_cat_name_cat".localized,
                            placeholder: "cat_leisure".localized
                        )
                    )
                }
                .padding(.horizontal, 1)
            }
            .scrollIndicators(.hidden)
            .contentMargins(.top, 32, for: .scrollContent)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black0)
        .ignoresSafeArea(.container, edges: .bottom)
    } // body
} // struct

// MARK: - Preview
#Preview {
    CreateCategoryView()
}
