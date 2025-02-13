//
//  KeychainService.swift
//  Evently
//
//  Created by Theo Sementa on 12/02/2025.
//

import Foundation
import Security

public final class KeychainService {
    public static func retrieveItemFromKeychain<T: Decodable>(id: String, type: T.Type, accessGroup: String) -> T? {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: id,
            kSecAttrAccessGroup: accessGroup,
            kSecMatchLimit: kSecMatchLimitOne,
            kSecReturnData: true
        ]

        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)

        if status != errSecSuccess {
            if let errorMessage = SecCopyErrorMessageString(status, nil) {
                print("❌ Erreur Keychain: \(errorMessage)")
            } else {
                print("❌ Erreur inconnue. Code: \(status)")
            }
            return nil
        }

        guard let data = result as? Data else {
            print("❌ Erreur: Aucun résultat trouvé ou données invalides.")
            return nil
        }

        do {
            let item = try JSONDecoder().decode(T.self, from: data)
            return item
        } catch {
            print("❌ Erreur de décodage JSON: \(error)")
            return nil
        }
    }

    public static func setItemToKeychain<T: Codable>(id: String, data: T, accessGroup: String) {
        do {
            let encodedData = try JSONEncoder().encode(data)

            let query: [CFString: Any] = [
                kSecClass: kSecClassGenericPassword,
                kSecAttrAccount: id,
                kSecAttrAccessGroup: accessGroup
            ]

            var status = SecItemCopyMatching(query as CFDictionary, nil)

            if status == errSecSuccess {
                let attributesToUpdate: [CFString: Any] = [
                    kSecValueData: encodedData
                ]
                status = SecItemUpdate(query as CFDictionary, attributesToUpdate as CFDictionary)
            } else {
                var newItem = query
                newItem[kSecValueData] = encodedData
                newItem[kSecAttrAccessible] = kSecAttrAccessibleAfterFirstUnlock
                status = SecItemAdd(newItem as CFDictionary, nil)
            }

            if status != errSecSuccess {
                if status == errSecMissingEntitlement {
                    print("⚠️ Les entitlements ne sont pas configurés correctement.")
                }
                if let errorMessage = SecCopyErrorMessageString(status, nil) {
                    print("⚠️ Erreur Keychain: \(errorMessage)")
                } else {
                    print("⚠️ Erreur Keychain inconnue. Code: \(status)")
                }
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
