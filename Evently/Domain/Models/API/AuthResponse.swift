//
//  AuthResponse.swift
//  Evently
//
//  Created by Theo Sementa on 04/02/2025.
//

import Foundation

struct AuthResponse: Codable {
    var needStepTwo: Bool?
    var user: UserModel?
}
