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
    var password: String?
    var token: String?
    var refreshToken: String?
    var isCompleted: Bool?

    /// Default
    init(
        id: Int? = nil,
        firstName: String? = nil,
        lastName: String? = nil,
        userName: String? = nil,
        email: String? = nil,
        token: String? = nil,
        refreshToken: String? = nil,
        isCompleted: Bool? = nil
    ) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.userName = userName
        self.email = email
        self.token = token
        self.refreshToken = refreshToken
        self.isCompleted = isCompleted
    }

    /// Register body
    init(
        firstName: String? = nil,
        lastName: String? = nil,
        email: String? = nil,
        password: String? = nil
    ) {
        self.id = nil
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.password = password
    }
}
