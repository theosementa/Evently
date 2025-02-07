//
//  CreateEventViewModel.swift
//  Evently
//
//  Created by Theo Sementa on 05/02/2025.
//

import Foundation

@Observable
final class CreateEventViewModel {

    var currentStep: Int = 1
    var currentEventID: Int?
    var currentInviteToken: String?

    var name: String = ""
    var selectedCategory: CategoryModel?
    var selectedFolder: FolderModel?

    var date: Date = .now
    var frequency: EventFrequency = .unique

    var selectedFriends: [UserModel] = []
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
                    targetDate: date
                )
            ) {
                currentEventID = newEvent.id
                await fetchInviteTokenFromCurrentEventInCreation()
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
