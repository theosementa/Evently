//
//  Navigation+Push.swift
//  Evently
//
//  Created by Theo Sementa on 01/02/2025.
//

import NavigationKit

extension Router where Destination == NavigationDestination {

    func pushDetail() {
        navigateTo(.detailFitted)
    }

    func pushStepTwo() {
        navigateTo(.stepTwo)
    }
}
