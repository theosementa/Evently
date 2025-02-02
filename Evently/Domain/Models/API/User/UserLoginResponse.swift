//
//  UserLoginResponse.swift
//  Evently
//
//  Created by Theo Sementa on 02/02/2025.
//

import Foundation

struct UserLoginResponse: Codable {
    var id: Int?
    var username: String?
    var firstName: String?
    var lastName: String?
    var email: String?
    var token: String?
    var refreshToken: String?
}
