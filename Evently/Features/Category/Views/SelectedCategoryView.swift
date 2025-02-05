//
//  SelectedCategoryView.swift
//  Evently
//
//  Created by Theo Sementa on 05/02/2025.
//

import SwiftUI

struct SelectedCategoryView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var searchText: String = ""
    
    // MARK: -
    var body: some View {
        VStack(spacing: 32) {
            VStack(spacing: 24) {
                HStack {
                    HStack(spacing: 12) {
                        Image(.tag)
                        Text("add_category_title".localized)
                            .font(.Content.xlBold)
                    }
                    Spacer()
                    TinyActionButton(icon: .xmark) { dismiss() }
                }
                CustomSearchBar(text: $searchText)
            }
            
            Separator()
            
            VStack(spacing: 8) {
                Text("zdzd")
                    .font(.Content.mediumSemiBold)
                ActionButton(
                    config: .init(
                        style: .default,
                        icon: .plusCircle,
                        title: <#T##String#>
                    ),
                    action: <#T##() async -> Void#>
                )
            }
            
            Separator()
            
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black0)
    } // body
} // struct

// MARK: - Preview
#Preview {
    SelectedCategoryView()
        .preferredColorScheme(.dark)
}
