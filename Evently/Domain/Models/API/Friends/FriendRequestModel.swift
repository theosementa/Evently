//
//  FriendRequestModel.swift
//  Evently
//
//  Created by Theo Sementa on 07/02/2025.
//

import Foundation

struct FriendRequestModel: Codable, Identifiable {
    var id: Int?
    var asker: UserModel?
    var receiver: UserModel?
}
