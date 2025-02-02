//
//  UserModel.swift
//  Evently
//
//  Created by Theo Sementa on 02/02/2025.
//

import Foundation

struct UserModel: Codable, Identifiable {
    var id: Int?
    var firstName: String?
    var lastName: String?
    var userName: String?
    var email: String?
    var token: String?
    var refreshToken: String?
}
