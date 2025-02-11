//
//  String+Extensions.swift
//  Evently
//
//  Created by Theo Sementa on 01/02/2025.
//

import Foundation

extension String {

    var localized: String {
        return NSLocalizedString(self, comment: "")
    }

    var isBlank: Bool {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    func toDate() -> Date? {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return dateFormatter.date(from: self)
    }

}

extension String {

    static func generateRandomString(length: Int = 10) -> String {
        let characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
        return String((0..<length).map { _ in characters.randomElement()! })
    }

}
