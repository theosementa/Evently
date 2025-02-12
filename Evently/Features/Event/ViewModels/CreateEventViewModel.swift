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

    var name: String = ""
    var selectedCategory: CategoryModel?
    var selectedFolder: FolderModel?

    var date: Date = .now
    var frequency: EventFrequency = .unique

    var selectedFriends: [UserModel] = []
    var inviteToken: String = String.generateRandomString()

    var event: EventModel?

    init(event: EventModel? = nil) {
        if let event {
            self.event = event
            name = event.name
            selectedCategory = event.category
            selectedFolder = event.folder
            date = event.targetDate
            frequency = event.frequency ?? .unique
        }
    }

    var isEditing: Bool {
        return event != nil
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
            createEvent()
            dismiss()
        } else if currentStep == 2 {
            if maxStep > 2 {
                currentStep = 3
            } else {
                createEvent()
                dismiss()
            }
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
            if let event, let eventID = event.id {
                await EventStore.shared.updateEvent(
                    id: eventID,
                    event: event
                )
            } else {
                await EventStore.shared.createEvent(
                    event: .init(
                        name: name,
                        frequency: frequency,
                        categoryID: categoryID,
                        targetDate: date,
                        inviteToken: maxStep == 2 ? nil : inviteToken,
                        folderID: selectedFolder?.id,
                        friends: selectedFriends.compactMap(\.username)
                    )
                )
            }
        }
    }

}

extension CreateEventViewModel {

    var isFirstStepValid: Bool {
        return !name.isBlank && selectedCategory != nil
    }

}
