//
//  CustomDatePicker.swift
//  Evently
//
//  Created by Theo Sementa on 06/02/2025.
//

import SwiftUI

struct CustomDatePicker: View {

    @Binding var selectedDate: Date

    @State private var isDatePickerVisible: Bool = false

    // MARK: -
    var body: some View {
        VStack(spacing: 6) {
            Text("add_event_choose_date".localized)
                .font(.Content.smallSemiBold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 8)

            VStack(spacing: 16) {
                Button(action: {
                    withAnimation(.smooth) {
                        isDatePickerVisible.toggle()
                    }
                }, label: {
                    HStack(spacing: 8) {
                        Image(.calendar)
                            .resizable()
                            .renderingMode(.template)
                            .frame(width: 20, height: 20)

                        Text(selectedDate.formatted(date: .numeric, time: .omitted))
                            .font(.Content.mediumBold)
                            .contentTransition(.numericText())
                    }
                    .frame(maxWidth: .infinity)
                })

                if isDatePickerVisible {
                    DatePicker(
                        "",
                        selection: $selectedDate.animation(.smooth),
                        displayedComponents: .date
                    )
                    .datePickerStyle(.graphical)
                }
            }
            .foregroundStyle(Color.white0)
            .padding(.horizontal)
            .padding(.vertical, 14)
            .frame(maxWidth: .infinity)
            .background {
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(Color.black100)
                    .stroke(Color.black200, lineWidth: 1)
            }
            .padding(1)
            .clipped()
        }
    } // body
} // struct

// MARK: - Preview
#Preview {
    @Previewable @State var selectedDate: Date = .now
    CustomDatePicker(selectedDate: $selectedDate)
        .preferredColorScheme(.dark)
        .padding()
        .background(Color.black0)
}
