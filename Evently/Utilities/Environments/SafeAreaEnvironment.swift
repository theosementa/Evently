//
//  SafeAreaEnvironment.swift
//  POC_SideMenu
//
//  Created by Theo Sementa on 04/02/2025.
//

import Foundation
import SwiftUI

private struct SafeAreaInsetsKey: EnvironmentKey {
    static var defaultValue: EdgeInsets {
        let scene = UIApplication.shared.connectedScenes.first(
            where: { $0.activationState == .foregroundActive }
        ) as? UIWindowScene
        let window = scene?.windows.first(where: { $0.isKeyWindow })
        return window?.safeAreaInsets.insets ?? .init()
    }
}

extension EnvironmentValues {

    var safeAreaInsets: EdgeInsets {
        self[SafeAreaInsetsKey.self]
    }
}

private extension UIEdgeInsets {

    var insets: EdgeInsets {
        EdgeInsets(top: top, leading: left, bottom: bottom, trailing: right)
    }
}
