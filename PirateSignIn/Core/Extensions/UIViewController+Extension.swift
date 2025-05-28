//
//  UIViewController+Extension.swift
//  PirateSignIn
//
//  Created by 김건우 on 5/29/25.
//

import UIKit

extension UIViewController {
    
    /// <#Description#>
    /// - Parameter textField: <#textField description#>
    func becomeFirstResponderIfNeeded(_ textField: UITextField) {
        if textField.canBecomeFirstResponder {
            textField.becomeFirstResponder()
        }
    }
    
    /// <#Description#>
    /// - Parameter textField: <#textField description#>
    func resignFirstResponderIfNeeded(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
}

extension UIViewController {
    
    /// <#Description#>
    func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
    }

    @objc func dismissKeyboard() {
        self.view.window?.endEditing(true)
    }
}
