//
//  ProgressBar.swift
//  Evently
//
//  Created by Theo Sementa on 02/02/2025.
//

import SwiftUI

struct ProgressBar: View {

    // builder
    var currentStep: Int
    var maxStep: Int

    var percentage: Double {
        return Double(currentStep) / Double(maxStep)
    }

    @State private var height: CGFloat = 0
    
    // MARK: -
    var body: some View {
        GeometryReader { geometry in
            Text("Etape \(currentStep) / \(maxStep)")
                .font(.Content.smallSemiBold)
                .foregroundStyle(Color.black100)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .frame(maxWidth: geometry.size.width * percentage, alignment: .leading)
                .background {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(Color.white0)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .background {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(Color.black200)
                }
                .onGeometryChange(for: CGSize.self, of: \.size) { newValue in
                    height = newValue.height
                }
        }
        .frame(height: height)
    } // body
} // struct

// MARK: - Preview
#Preview {
    ProgressBar(currentStep: 2, maxStep: 3)
        .padding()
        .background(Color.blue)
        .preferredColorScheme(.dark)
}
