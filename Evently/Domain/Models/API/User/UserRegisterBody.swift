//
//  UserRegisterBody.swift
//  Evently
//
//  Created by Theo Sementa on 02/02/2025.
//

import Foundation

struct UserRegisterBody: Codable {
    var email: String
    var firstName: String
    var lastName: String
    var password: String
}
