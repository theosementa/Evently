//
//  Int+Extensions.swift
//  Evently
//
//  Created by Theo Sementa on 11/02/2025.
//

import Foundation

struct YearMonthDay {
    let year: Int
    let month: Int
    let day: Int
}

extension Int {

    func toYearsMonthsDays() -> YearMonthDay {
        let years = self / 365
        let remainingAfterYears = self % 365
        let months = remainingAfterYears / 30
        let remainingDays = remainingAfterYears % 30

        return YearMonthDay(year: years, month: months, day: remainingDays)
    }

}
