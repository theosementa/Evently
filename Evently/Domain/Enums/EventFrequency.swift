//
//  EventFrequency.swift
//  Evently
//
//  Created by Theo Sementa on 06/02/2025.
//

import Foundation

enum EventFrequency: String, Codable, CaseIterable {
    case none
    //    case daily
    //    case weekly
    case monthly = "monthly"
    case yearly = "yearly"
}

extension EventFrequency {

    var title: String {
        switch self {
        case .none:
            return "global_unique".localized
        case .monthly:
            return "global_monthly".localized
        case .yearly:
            return "global_yearly".localized
        }
    }

}
