//
//  Regex.swift
//  Evently
//
//  Created by Theo Sementa on 14/02/2025.
//

import Foundation

enum Regex: String {
    case name = "^[A-Za-záàâãéèêíïóôõöúçñÁÀÂÃÉÈÍÏÓÔÕÖÚÇÑœ'’ -]{1,33}$"
    case username = "^[A-Za-z0-9]{1,20}$"
    case email = "^([a-zA-Z0-9_\\-\\.]+)@([a-zA-Z0-9_\\-\\.]+)\\.([a-zA-Z]{2,5})$"
    case password = "^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9]).{8,}$"

    case uppercase = ".*[A-Z]+.*"
    case lowercase = ".*[a-z]+.*"
    case number = ".*[0-9]+.*"
    case specialChar = ".*[@$!%*?&]+.*"

    case startPassword = "^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9]).+$"
    case moreThan8 = ".{8,}"
}

extension Regex {
    static func ~=(text: String, regex: Regex) -> Bool {
        let stringTest = NSPredicate(format: "SELF MATCHES %@", regex.rawValue)
        return stringTest.evaluate(with: text)
    }
}
