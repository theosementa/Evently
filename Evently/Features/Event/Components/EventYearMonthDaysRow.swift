//
//  EventYearMonthDaysRow.swift
//  Evently
//
//  Created by Theo Sementa on 11/02/2025.
//

import SwiftUI

struct EventYearMonthDaysRow: View {

    // builder
    var event: EventModel

    // MARK: -
    var body: some View {
        let dates = event.remainingDays.toYearsMonthsDays()
        HStack(spacing: 20) {
            if dates.year > 0 {
                HStack(alignment: .bottom, spacing: 4) {
                    Text(dates.year.formatted())
                        .font(.Headline.head4)
                    Text(dates.year > 1 ? "detail_years".localized : "detail_year".localized)
                        .font(.Content.largeSemiBold)
                        .offset(y: -4)
                }
            }

            if dates.month > 0 {
                HStack(alignment: .bottom, spacing: 4) {
                    Text(dates.month.formatted())
                        .font(.Headline.head4)
                    Text(dates.month > 1 ? "detail_months".localized : "detail_month".localized)
                        .font(.Content.largeSemiBold)
                        .offset(y: -4)
                }
            }

            if dates.day > 0 {
                HStack(alignment: .bottom, spacing: 4) {
                    Text(dates.day.formatted())
                        .font(.Headline.head4)
                    Text(dates.day > 1 ? "detail_days".localized : "detail_day".localized)
                        .font(.Content.largeSemiBold)
                        .offset(y: -4)
                }
            }
        }
    } // body
} // struct

// MARK: - Preview
#Preview {
    EventYearMonthDaysRow(event: .preview)
}
