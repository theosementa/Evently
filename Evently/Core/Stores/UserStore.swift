//
//  UserStore.swift
//  Evently
//
//  Created by Theo Sementa on 02/02/2025.
//

import Foundation

@Observable
final class UserStore {
    static let shared = UserStore()

    var currentUser: UserModel?
}
