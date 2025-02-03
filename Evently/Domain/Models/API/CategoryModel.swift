//
//  CategoryModel.swift
//  Evently
//
//  Created by Theo Sementa on 02/02/2025.
//

import Foundation
import SwiftUICore

struct CategoryModel: Codable, Identifiable {
    var id: Int?
    var rawName: String?
    var rawIcon: String?
    var rawColor: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case rawName = "name"
        case rawIcon = "icon"
        case rawColor = "color"
    }
}

extension CategoryModel {
    
    var name: String {
        return rawName?.localized ?? ""
    }
    
    var icon: String {
        return rawIcon ?? "" // TODO: Prendre un exclamation mark
    }
    
    var color: String {
        return rawColor ?? ""
    }
    
    var gradient: LinearGradient {
        return LinearGradient(colorHex: color)
    }
    
}
