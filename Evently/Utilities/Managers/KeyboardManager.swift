//
//  KeyboardManager.swift
//  Evently
//
//  Created by Theo Sementa on 12/02/2025.
//

import UIKit
import SwiftUI
import Combine

class KeyboardManager: ObservableObject {
    static let shared = KeyboardManager()
    @Published var keyboardHeight: CGFloat = 0
    @Published var isVisible = false

    var keyboardShowCancellable: Cancellable?
    var keyboardHideCancellable: Cancellable?

    func hideKeyboard() {
        if isVisible {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }

    init() {
        keyboardShowCancellable = NotificationCenter.default
            .publisher(for: UIResponder.keyboardWillShowNotification)
            .sink { [weak self] notification in
                guard let self = self else { return }

                guard let userInfo = notification.userInfo else { return }
                guard let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }

                withAnimation {
                    self.isVisible = true
                    self.keyboardHeight = keyboardFrame.height
                }
            }

        keyboardHideCancellable = NotificationCenter.default
            .publisher(for: UIResponder.keyboardWillHideNotification)
            .sink { [weak self] _ in
                guard let self = self else { return }

                DispatchQueue.main.async {
                    withAnimation {
                        self.isVisible = false
                        self.keyboardHeight = 0
                    }
                }
            }
    }

    deinit {
        keyboardShowCancellable?.cancel()
        keyboardHideCancellable?.cancel()
    }
}
