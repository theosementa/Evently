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

    func pushProfile() {
        navigateTo(.profile)
    }

    func pushCreateEvent() {
        navigateTo(.createEvent)
    }
}
