//
//  FriendStore.swift
//  Evently
//
//  Created by Theo Sementa on 08/02/2025.
//

import Foundation

@Observable
final class FriendStore {
    static let shared = FriendStore()

    var friends: [UserModel] = []
    var requests: [FriendRequestModel] = []
    var sentRequests: [FriendRequestModel] = []
}

extension FriendStore {

    @MainActor
    func fetchFriends() async {
        do {
            let friends = try await UserService.fetchFriends()
            self.friends = friends
        } catch { NetworkService.handleError(error: error) }
    }

    @MainActor
    func fetchRequests() async {
        do {
            let requests = try await FriendService.fetchAllRequests()
            self.requests = requests
        } catch let error {
            if let networkError = error as? NetworkError {
                BannerManager.shared.banner = networkError.banner
            }
        }
    }

    @MainActor
    func fetchSentRequests() async {
        do {
            let sentRequests = try await FriendService.fetchAllRequestsSent()
            self.sentRequests = sentRequests
        } catch let error {
            if let networkError = error as? NetworkError {
                BannerManager.shared.banner = networkError.banner
            }
        }
    }

    @MainActor
    func sendRequest(username: String) async -> Bool {
        do {
            let request = try await FriendService.sendRequest(to: username)
            self.sentRequests.append(request)
            BannerManager.shared.banner = Banner.friendRequestSend
            return true
        } catch let error {
            if let networkError = error as? NetworkError {
                if networkError == .notFound {
                    BannerManager.shared.banner = Banner.friendRequestInvalidUsername
                } else {
                    BannerManager.shared.banner = networkError.banner
                }
            }
            return false
        }
    }

    @MainActor
    func deleteFriend(user: UserModel) async {
        guard let username = user.username else { return }

        do {
            try await FriendService.delete(username: username)
            self.friends.removeAll(where: { $0.username == username })
        } catch let error {
            if let networkError = error as? NetworkError {
                BannerManager.shared.banner = networkError.banner
            }
        }
    }

    @MainActor
    func answerRequest(requestID: Int, answer: Bool) async {
        do {
            let request = try await FriendService.answerRequest(id: requestID, answer: answer)

            if let isAccepted = request.isAccepted, isAccepted {
                if let user = request.user {
                    self.friends.append(user)
                    BannerManager.shared.banner = Banner.friendRequestAccepted
                }
            } else {
                BannerManager.shared.banner = Banner.friendRequestRejected
            }

            self.requests.removeAll(where: { $0.id == requestID })
        } catch let error {
            if let networkError = error as? NetworkError {
                BannerManager.shared.banner = networkError.banner
            }
        }
    }

}
