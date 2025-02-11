//
//  EventDetailRow.swift
//  Evently
//
//  Created by Theo Sementa on 11/02/2025.
//

import SwiftUI

struct EventDetailRow: View {
    // builder
    var event: EventModel

    // MARK: -
    var body: some View {
        VStack(spacing: event.folder == nil ? 16 : 8) {
            VStack(alignment: .leading, spacing: 0) {
                Text(event.name)
                    .font(.Content.xlBold)
                    .foregroundStyle(Color.white0)

                Text(event.targetDate.formatted(date: .long, time: .omitted))
                    .font(.Content.mediumSemiBold)
                    .foregroundStyle(Color.white200)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            let recurrence = event.frequency?.rawValue.capitalized ?? ""
            Text("add_event_reccurence".localized + " : " + recurrence)
                .font(.Content.mediumSemiBold)
                .frame(maxWidth: .infinity, alignment: .leading)

            EventYearMonthDaysRow(event: event)
                .frame(maxWidth: .infinity, alignment: .leading)

            if let folder = event.folder {
                HStack(spacing: 6) {
                    Image(.folder)
                        .resizable()
                        .frame(width: 16, height: 16)
                    Text(folder.name)
                        .font(.Content.smallBold)
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .background {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(Color.white0)
                        .opacity(0.3)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }

            HStack(alignment: .bottom, spacing: 32) {
                Image(ImageResource(name: event.category?.icon ?? "", bundle: .main))
                    .resizable()
                    .renderingMode(.template)
                    .foregroundStyle(Color.white0)
                    .frame(width: 18, height: 18)
                    .padding(8)
                    .background {
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(Color.white0)
                            .opacity(0.3)
                    }

                VStack(alignment: .trailing, spacing: 0) {
                    Text(event.targetDate.daysFromNow.formatted())
                        .font(.Headline.head4)
                    Text("detail_rest_time".localized)
                        .font(.Content.largeSemiBold)
                }
                .foregroundStyle(Color.white0)
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
        .padding(24)
        .background {
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(backgroundStyle)
        }
    } // body

    private var backgroundStyle: AnyShapeStyle {
        if let gradient = event.category?.gradient {
            AnyShapeStyle(gradient)
        } else {
            AnyShapeStyle(Color.black100)
        }
    }
} // struct

// MARK: - Preview
#Preview {
    EventDetailRow(event: .preview)
        .preferredColorScheme(.dark)
        .padding()
        .background(Color.black0)
}
