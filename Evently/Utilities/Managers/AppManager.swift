//
//  AppManager.swift
//  Evently
//
//  Created by Theo Sementa on 31/01/2025.
//

import Foundation
import KeychainKit

@Observable
final class AppManager {
    static let shared = AppManager()

    var appState: AppState = .idle

}
