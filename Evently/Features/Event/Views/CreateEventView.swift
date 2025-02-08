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

    @State private var viewModel: CreateEventViewModel = .init()

    // MARK: -
    var body: some View {
        VStack(spacing: 48) {
            VStack(spacing: 16) {
                HStack {
                    TinyActionButton(icon: .chevronBack) {
                        if viewModel.currentStep == 1 {
                            viewModel.deleteCurrentEventInCreation()
                            dismiss()
                        } else {
                            viewModel.currentStep -= 1
                        }
                    }

                    HStack(spacing: 12) {
                        Image(.calendar)
                        Text("add_event_title".localized)
                            .font(.Content.xlBold)
                    }
                    .frame(maxWidth: .infinity)

                    TinyActionButton(icon: .chevronBack) { dismiss() }
                        .opacity(0)
                }
                .frame(maxWidth: .infinity)

                ProgressBar(currentStep: viewModel.currentStep, maxStep: 3)
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

                    CategoryPicker(selectedCategory: $viewModel.selectedCategory)

                    FolderPicker(selectedFolder: $viewModel.selectedFolder)
                case 2:
                    CustomDatePicker(selectedDate: $viewModel.date)

                    FrequencyPicker(frequency: $viewModel.frequency)
                case 3:
                    FriendsPicker(selectedFriends: $viewModel.selectedFriends)
                    if let inviteToken = viewModel.currentInviteToken {
                        ActionButton(
                            config: .init(
                                style: .secondary,
                                icon: .copy,
                                title: "global_copy_invite_link".localized,
                                isFill: true
                            )
                        ) {
                            UIPasteboard.general.string = inviteToken
                            BannerManager.shared.banner = .inviteLink
                        }
                    }
                default:
                    EmptyView()
                }
            }

            Spacer()

            ActionButton(
                config: .init(
                    style: viewModel.isFirstStepValid ? .default : .disabled,
                    title: viewModel.currentStep == 1
                    ? "add_event_nextstep".localized
                    : "global_finish".localized,
                    isFill: true
                )
            ) {
                if viewModel.currentStep == 3 {
                    viewModel.addFriendsToCurrentEventInCreation()
                    dismiss()
                } else if viewModel.currentStep == 2 {
                    viewModel.createEvent()
                    viewModel.currentStep = 3
                } else {
                    if viewModel.isFirstStepValid {
                        viewModel.currentStep = 2
                    }
                }
            }
        }
        .padding(24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black0)
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: viewModel.currentStep) { oldValue, newValue in
            if oldValue == 3 && newValue < 3 {
                viewModel.deleteCurrentEventInCreation()
            }
        }
    } // body
} // struct

// MARK: - Preview
#Preview {
    CreateEventView()
        .preferredColorScheme(.dark)
}
