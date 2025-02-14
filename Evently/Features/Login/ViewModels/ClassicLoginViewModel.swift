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

    var isEmailAvailable: Bool = true
    var isInStepTwo: Bool = false

    var email: String = ""
    var password: String = ""
    var confirmPassword: String = ""

    var firstName: String = ""
    var lastName: String = ""
}

extension ClassicLoginViewModel {

    func resetData() {
        email = ""
        password = ""
        confirmPassword = ""
    }

    func loginWithCredentials() async {
        await UserStore.shared.loginWithCredentials(
            email: email,
            password: password
        )
    }

    func isReadyToCreateAnAccount() -> Bool {
        return isEmailAvailable
        && email ~= Regex.email
        && password ~= Regex.password
        && password == confirmPassword
    }

    func register() async -> UserModel? {
        return await UserStore.shared.register(
            firstName: firstName,
            lastName: lastName,
            email: email,
            password: password
        )
    }

}
