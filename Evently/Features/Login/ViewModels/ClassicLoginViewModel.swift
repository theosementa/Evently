//
//  ClassicLoginViewModel.swift
//  Evently
//
//  Created by Theo Sementa on 05/02/2025.
//

import Foundation

@Observable
final class ClassicLoginViewModel {
    static let shared = ClassicLoginViewModel()

    var email: String = ""
    var password: String = ""
    var confirmPassword: String = ""

}

extension ClassicLoginViewModel {

    func resetData() {
        email = ""
        password = ""
        confirmPassword = ""
    }

    func loginWithCredentials() {
        Task {
            await UserStore.shared.loginWithCredentials(email: email, password: password)
        }
    }

//    func register

}
