//
//  UIViewController+Extension.swift
//  PirateSignIn
//
//  Created by 김건우 on 5/29/25.
//

import UIKit

extension UIViewController {

    /// 지정된 텍스트 필드가 첫 번째 응답자가 될 수 있을 경우, 첫 번째 응답자로 설정합니다.
    /// - Parameter textField: 첫 번째 응답자로 설정할 텍스트 필드입니다.
    func becomeFirstResponderIfNeeded(_ textField: UITextField) {
        if textField.canBecomeFirstResponder {
            textField.becomeFirstResponder()
        }
    }

    /// 지정된 텍스트 필드가 첫 번째 응답자인 경우, 응답을 취소합니다.
    /// - Parameter textField: 응답을 취소할 텍스트 필드입니다.
    func resignFirstResponderIfNeeded(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
}

extension UIViewController {
    
    /// 지정된 뷰를 탭했을 때 키보드를 숨기도록 제스처를 등록합니다.
    /// - Parameter view: 탭 제스처를 추가할 대상 뷰입니다.
    func hideKeyboardWhenTappedAround(_ view: UIView) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    @objc func dismissKeyboard() {
        self.view.window?.endEditing(true)
    }
}
