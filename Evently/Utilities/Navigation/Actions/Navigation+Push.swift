//
//  Navigation+Push.swift
//  Evently
//
//  Created by Theo Sementa on 01/02/2025.
//

import NavigationKit

extension Router where Destination == NavigationDestination {

    func pushStepTwo() {
        navigateTo(.stepTwo)
    }

    func pushClassicLogin() {
        navigateTo(.classicLogin)
    }

    func pushClassicCreateAccount() {
        navigateTo(.createAccount)
    }

    func pushProfile() {
        navigateTo(.profile)
    }

    func pushMyFriends() {
        navigateTo(.myFriends)
    }

    func pushMyFriendRequests() {
        navigateTo(.myFriendRequests)
    }

    func pushMySentRequests() {
        navigateTo(.mySentRequests)
    }

    func pushManageMyAccount() {
        navigateTo(.manageMyAccount)
    }

    func pushCreateEvent(event: EventModel? = nil) {
        navigateTo(.createEvent(event: event))
    }

    func pushEventDetail(eventID: Int) {
        navigateTo(.eventDetail(eventID: eventID))
    }
}
