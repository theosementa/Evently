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

    init(event: EventModel? = nil) {
        self._viewModel = .init(wrappedValue: .init(event: event))
    }

    @FocusState var isFocused: Bool

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

            ScrollView {
                VStack(spacing: viewModel.currentStep == 3 ? 32 : 24) {
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
                        .focused($isFocused)

                        CategoryPicker(selectedCategory: $viewModel.selectedCategory)

                        FolderPicker(selectedFolder: $viewModel.selectedFolder)
                    case 2:
                        TogglePicker(
                            isSelected: $viewModel.isAllDay,
                            title: "add_event_event_duration".localized,
                            text: "add_event_all_day".localized
                        )

                        CustomDatePicker(
                            selectedDate: $viewModel.date,
                            needToPresentHour: !viewModel.isAllDay
                        )

                        FrequencyPicker(frequency: $viewModel.frequency)
                    case 3:
                        FriendsPicker(selectedFriends: $viewModel.selectedFriends)
                        VStack(alignment: .leading, spacing: 12) {
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

                            Text("add_event_invite_friends_desc_link".localized)
                                .font(.Content.smallSemiBold)
                                .padding(.horizontal, 8)
                        }
                    default:
                        EmptyView()
                    }
                }
            }
            .scrollIndicators(.hidden)

            ActionButton(
                config: .init(
                    style: viewModel.currentActionButtonStyle,
                    title: viewModel.currentActionButtonTitle,
                    isFill: true
                )
            ) {
                viewModel.currentActionForStep(dismiss: dismiss)
            }
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
        .onAppear {
            isFocused = true
        }
    } // body
} // struct

// MARK: - Preview
#Preview {
    CreateEventView()
        .preferredColorScheme(.dark)
}
