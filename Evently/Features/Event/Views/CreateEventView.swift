//
//  CreateEventView.swift
//  Evently
//
//  Created by Theo Sementa on 05/02/2025.
//

import SwiftUI
import NavigationKit

struct CreateEventView: View {

    @Environment(\.dismiss) private var dismiss

    @State private var viewModel: CreateEventViewModel
    @StateObject private var keyboardManager: KeyboardManager = .init()

    init(event: EventModel? = nil) {
        self._viewModel = .init(wrappedValue: .init(event: event))
    }

    // MARK: -
    var body: some View {
        VStack(spacing: 48) {
            VStack(spacing: 16) {
                HStack(spacing: 8) {
                    TinyActionButton(icon: .chevronBack) {
                        if viewModel.currentStep == 1 { dismiss() } else {
                            viewModel.currentStep -= 1
                        }
                    }

                    Text("add_event_title".localized)
                        .font(.Content.xlBold)
                        .frame(maxWidth: .infinity)

                    TinyActionButton(icon: .chevronBack) { dismiss() }
                        .opacity(0)
                }
                .frame(maxWidth: .infinity)

                ProgressBar(currentStep: viewModel.currentStep, maxStep: viewModel.maxStep)
            }

            VStack(spacing: 24) {
                switch viewModel.currentStep {
                case 1:
                    CustomTextField(
                        text: $viewModel.name,
                        config: .init(
                            title: "add_event_name".localized,
                            placeholder: "add_event_name_placeholder".localized
                        )
                    )
                    .submitLabel(.done)

                    CategoryPicker(selectedCategory: $viewModel.selectedCategory)

                    FolderPicker(selectedFolder: $viewModel.selectedFolder)
                case 2:
                    CustomDatePicker(selectedDate: $viewModel.date)

                    FrequencyPicker(frequency: $viewModel.frequency)
                case 3:
                    FriendsPicker(selectedFriends: $viewModel.selectedFriends)
                    ActionButton(
                        config: .init(
                            style: .secondary,
                            icon: .copy,
                            title: "global_copy_invite_link".localized,
                            isFill: true
                        )
                    ) {
                        UIPasteboard.general.string = viewModel.inviteToken
                        BannerManager.shared.banner = .inviteLink
                    }
                default:
                    EmptyView()
                }
            }

            Spacer()

            ActionButton(
                config: .init(
                    style: viewModel.currentActionButtonStyle,
                    title: viewModel.currentActionButtonTitle,
                    isFill: true
                )
            ) {
                viewModel.currentActionForStep(dismiss: dismiss)
            }
            .padding(.bottom, keyboardManager.isVisible ? 16 : 0)
        }
        .padding(24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black0)
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: viewModel.selectedFolder) {
            if viewModel.selectedFolder != nil {
                viewModel.maxStep = 2
            } else {
                viewModel.maxStep = 3
            }
        }
    } // body
} // struct

// MARK: - Preview
#Preview {
    CreateEventView()
        .preferredColorScheme(.dark)
}
