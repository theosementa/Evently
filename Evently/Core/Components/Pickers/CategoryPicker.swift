//
//  CategoryPicker.swift
//  Evently
//
//  Created by Theo Sementa on 05/02/2025.
//

import SwiftUI
import NavigationKit

struct CategoryPicker: View {
    
    @EnvironmentObject private var router: Router<NavigationDestination>
    
    // MARK: -
    var body: some View {
        VStack(spacing: 6) {
            Text("add_event_category".localized)
                .font(.Content.smallSemiBold)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ActionButton(
                config: .init(
                    style: .default,
                    icon: .plusCircle,
                    title: "add_event_choose_category".localized,
                    isFill: true
                )
            ) {
                
            }
        }
    } // body
} // struct

// MARK: - Preview
#Preview {
    CategoryPicker()
        .padding()
        .background(Color.black0)
        .preferredColorScheme(.dark)
}
