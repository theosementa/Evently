//
//  CreateEventViewModel.swift
//  Evently
//
//  Created by Theo Sementa on 05/02/2025.
//

import Foundation
import SwiftUI

@Observable
final class CreateEventViewModel {

    var currentStep: Int = 1
    var maxStep: Int = 3
    var currentEvent: EventModel?
    var currentInviteToken: String?

    var name: String = ""
    var selectedCategory: CategoryModel?
    var selectedFolder: FolderModel?

    var date: Date = .now
    var frequency: EventFrequency = .unique

    var selectedFriends: [UserModel] = []

    var currentEventID: Int? {
        return currentEvent?.id
    }
}

extension CreateEventViewModel {

    var currentActionButtonStyle: ActionButtonStyle {
        switch currentStep {
        case 1:
            return isFirstStepValid ? .default : .disabled
        case 2:
            return .default
        case 3:
            return .default
        default:
            return .disabled
        }
    }

    var currentActionButtonTitle: String {
        switch currentStep {
        case 1:
            return "add_event_nextstep".localized
        case 2:
            return maxStep == 2 ? "global_finish".localized : "add_event_nextstep".localized
        case 3:
            return maxStep == 3 ? "global_finish".localized : "add_event_nextstep".localized
        default:
            return "Error"
        }
    }

    func currentActionForStep(dismiss: DismissAction) {
        if currentStep == 3 {
            addFriendsToCurrentEventInCreation()
            dismiss()
        } else if currentStep == 2 {
            createEvent()
            if maxStep > 2 {
                currentStep = 3
            } else { dismiss() }
        } else {
            if isFirstStepValid {
                currentStep = 2
            }
        }
    }
}

extension CreateEventViewModel {

    func createEvent() {
        Task {
            guard let selectedCategory, let categoryID = selectedCategory.id else { return }
            if let newEvent = await EventStore.shared.createEvent(
                event: .init(
                    name: name,
                    frequency: frequency,
                    categoryID: categoryID,
                    targetDate: date,
                    folderID: selectedFolder?.id
                )
            ) {
                currentEvent = newEvent
                await fetchInviteTokenFromCurrentEventInCreation()
            }
        }
    }

    func addFriendsToCurrentEventInCreation() {
        Task {
            if let currentEventID, let currentEvent, !selectedFriends.isEmpty {
                let friends = selectedFriends.compactMap(\.username)
                self.currentEvent?.friends?.append(contentsOf: friends)
                await EventStore.shared.updateEvent(id: currentEventID, event: currentEvent)
            }
        }
    }

    func fetchInviteTokenFromCurrentEventInCreation() async {
        if let currentEventID {
            self.currentInviteToken = await EventStore.shared.shareEvent(id: currentEventID)
        }
    }

    func deleteCurrentEventInCreation() {
        if let currentEventID {
            Task {
                await EventStore.shared.deleteEvent(id: currentEventID)
            }
        }
    }

}

extension CreateEventViewModel {

    var isFirstStepValid: Bool {
        return !name.isBlank && selectedCategory != nil
    }

}
