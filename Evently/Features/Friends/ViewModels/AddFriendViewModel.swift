//
//  AddFriendViewModel.swift
//  Evently
//
//  Created by Theo Sementa on 08/02/2025.
//

import Foundation

@Observable
final class AddFriendViewModel {
    var friendUsername: String = ""
}

extension AddFriendViewModel {

    @MainActor
    func sendRequest() async {
        do {
            try await FriendService.sendRequest(to: friendUsername)
        } catch {
            NetworkService.handleError(error: error)
        }
    }

}
