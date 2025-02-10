//
//  ClassicLoginViewModel.swift
//  Evently
//
//  Created by Theo Sementa on 05/02/2025.
//

import Foundation

@Observable
final class ClassicLoginViewModel {

    var email: String = ""
    var password: String = ""

}

extension ClassicLoginViewModel {

    func loginWithCredentials() {
        Task {
            await UserStore.shared.loginWithCredentials(email: email, password: password)
        }
    }

//    func register

}
