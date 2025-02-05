//
//  CreateEventView.swift
//  Evently
//
//  Created by Theo Sementa on 05/02/2025.
//

import SwiftUI

struct CreateEventView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var viewModel: CreateEventViewModel = .init()
    
    // MARK: -
    var body: some View {
        VStack(spacing: 48) {
            VStack(spacing: 16) {
                HStack {
                    Image(.calendar)
                        
                    Text("add_event_title".localized)
                        .font(.Content.xlBold)
                }
                .frame(maxWidth: .infinity)
                .overlay(alignment: .leading) {
                    TinyActionButton(icon: .chevronBack) { dismiss() }
                }
                
                ProgressBar(currentStep: viewModel.currentStep, maxStep: 2)
            }
            
            CustomTextField(
                text: $viewModel.name,
                config: .init(
                    title: "add_event_name".localized,
                    placeholder: "add_event_name_placeholder".localized
                )
            )
            
            Spacer()
        }
        .padding(24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black0)
    } // body
} // struct

// MARK: - Preview
#Preview {
    CreateEventView()
        .preferredColorScheme(.dark)
}
