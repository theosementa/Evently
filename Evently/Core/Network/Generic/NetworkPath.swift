//
//  NetworkConstant.swift
//  LifeFlow
//
//  Created by Theo Sementa on 09/03/2024.
//

import Foundation

struct NetworkPath {
    static let baseURL: String = "https://theodev.myftp.org:89"

    struct Auth {
        static let apple: String = "/auth/apple"
        static let google: String = "/auth/google"
        static let socket: String = "/auth/socket"
        static let stepTwo: String = "/auth/from-provider/step-two"
    }

    struct User {
        static let base: String = "/user"
        static let me: String = "/user/me"
        static let register: String = "/user/register"
        static let login: String = "/user/login"
        static let friends: String = "/user/friends"
        static func refreshToken(refreshToken: String) -> String {
            return "/user/refresh-token/\(refreshToken)"
        }
    }

    struct Category {
        static let base: String = "/categories"
        static let `default`: String = "/categories/default"
        static func categoryWithId(id: Int) -> String {
            return "/categories/\(id)"
        }
    }

    struct Event {
        static let base: String = "/events"
        static func eventWithId(id: Int) -> String {
            return "/events/\(id)"
        }
        static func share(id: Int) -> String {
            return "/events/share/\(id)"
        }
        static func leave(id: Int) -> String {
            return "/events/leave/\(id)"
        }
    }

    struct Folder {
        static let base: String = "/folders"
        static func folderWithId(id: Int) -> String {
            return "/folders/\(id)"
        }
        static func leave(id: Int) -> String {
            return "/folders/leave/\(id)"
        }
        static func share(id: Int) -> String {
            return "/folders/share/\(id)"
        }
        static let join: String = "/folders/join"
    }

    struct Friend {
        static let base: String  = "/friends-request"
        static let sentRequests: String = "/friends-request/sent"
        static func acceptOrReject(requestID: Int) -> String {
            return "/friends-request/\(requestID)"
        }
    }

}
