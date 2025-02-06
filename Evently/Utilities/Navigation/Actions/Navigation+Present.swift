//
//  Navigation+Present.swift
//  Evently
//
//  Created by Theo Sementa on 06/02/2025.
//

import Foundation
import NavigationKit
import SwiftUICore

extension Router where Destination == NavigationDestination {

    func presentSelectCategory(selectedCategory: Binding<CategoryModel?>) {
        presentSheet(.selectCategory(selectedCategory: selectedCategory))
    }

}
