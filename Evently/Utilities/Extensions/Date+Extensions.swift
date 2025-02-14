//
//  Date+Extensions.swift
//  Evently
//
//  Created by Theo Sementa on 06/02/2025.
//

import Foundation

extension Date {

    var daysFromNow: Int {
        let calendar = Calendar.current
        let end = calendar.startOfDay(for: self)
        let start = calendar.startOfDay(for: .now)
        let components = calendar.dateComponents([.day], from: start, to: end)
        return components.day ?? 0
    }

    func setTimeToZero() -> Date {
        var components = Calendar.current.dateComponents([.year, .month, .day], from: self)
        return Calendar.current.date(from: components)!
    }

}
