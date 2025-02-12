//
//  KeychainService.swift
//  Evently
//
//  Created by Theo Sementa on 12/02/2025.
//

import Foundation

public final class KeychainService {
    public static func retrieveItemFromKeychain<T: Decodable>(id: String, type: T.Type, accessGroup: String) -> T? {

        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: id,
            kSecAttrSynchronizable: false,
            kSecReturnData: true,
            kSecAttrAccessGroup: accessGroup,
            kSecMatchLimit: kSecMatchLimitOne
        ]

        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)

        guard status == errSecSuccess,
              let data = result as? Data else {
            return nil
        }

        do {
            let item = try JSONDecoder().decode(T.self, from: data)
            return item
        } catch {
            print("Erreur de décodage: \(error)")
            return nil
        }
    }

    public static func setItemToKeychain<T: Codable>(id: String, data: T, accessGroup: String) {
        do {
            let encodedData = try JSONEncoder().encode(data)

            let query: [CFString: Any] = [
                kSecClass: kSecClassGenericPassword,
                kSecAttrAccount: id,
                kSecAttrSynchronizable: false,
                kSecAttrAccessGroup: accessGroup,
                kSecValueData: encodedData
            ]

            SecItemDelete(query as CFDictionary)

            let status = SecItemAdd(query as CFDictionary, nil)
            if status != errSecSuccess {
                print("Erreur lors de l'enregistrement dans le Keychain: \(status)")
            }
        } catch {
            print("Erreur d'encodage: \(error)")
        }
    }

    public static func deleteItemFromKeychain(id: String) {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: id,
            kSecAttrSynchronizable: false
        ]

        let status = SecItemDelete(query as CFDictionary)

        if status != errSecSuccess && status != errSecItemNotFound {
            print("Erreur lors de la suppression de l'item du Keychain: \(status)")
        }
    }
}
