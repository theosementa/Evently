//
//  FrequencyPicker.swift
//  Evently
//
//  Created by Theo Sementa on 06/02/2025.
//

import SwiftUI

struct FrequencyPicker: View {

    @Binding var frequency: EventFrequency

    // MARK: -
    var body: some View {
        VStack(spacing: 6) {
            Text("add_event_reccurence".localized)
                .font(.Content.smallSemiBold)
                .frame(maxWidth: .infinity, alignment: .leading)

            Menu {
                ForEach(EventFrequency.allCases, id: \.self) { frequency in
                    Button(action: { self.frequency = frequency }, label: {
                        Text(frequency.title)
                    })
                }
            } label: {
                HStack(spacing: 8) {
                    Text(frequency.title)
                        .font(.Content.mediumBold)
                        .contentTransition(.numericText())

                    Image(.chevronMenu)
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 20, height: 20)
                }
                .foregroundStyle(Color.white0)
                .padding(.horizontal)
                .padding(.vertical, 14)
                .frame(maxWidth: .infinity )
                .background {
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .stroke(Color.white0, lineWidth: 2)
                }
            }
        }
    } // body
} // struct

// MARK: - Preview
#Preview {
    @Previewable @State var frequency: EventFrequency = .unique
    FrequencyPicker(frequency: $frequency)
        .preferredColorScheme(.dark)
        .padding()
        .background(Color.black0)
}
