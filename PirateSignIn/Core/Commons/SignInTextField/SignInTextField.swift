//
//  SignInTextField.swift
//  PirateSignIn
//
//  Created by 김건우 on 5/26/25.
//

import UIKit

/// 로그인 화면 등에서 아이디 및 패스워드 필드로 사용하는 커스텀 텍스트 필드 뷰입니다.
@IBDesignable
final class SignInTextField: NibView {

    /// 사용자가 입력한 내용을 보이지 않게 처리할지 여부를 나타냅니다.
    /// - Note: `true`로 설정하면 비밀번호 입력 필드처럼 문자 대신 점(`•`)으로 표시됩니다.
    @IBInspectable var isSecureField: Bool = false {
        didSet { inputField.isSecureTextEntry = isSecureField }
    }

    /// 입력 필드에 표시할 플레이스홀더 텍스트입니다.
    /// - Note: 입력 전 힌트로 표시되며, 사용자가 입력을 시작하면 사라집니다.
    @IBInspectable var placeholder: String? {
        didSet { inputField.placeholder = placeholder }
    }

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var inputField: UITextField!

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadFromNib(owner: self)
        setupInputField()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadFromNib(owner: self)
        setupInputField()
    }

    private func setupInputField() {
        container.layer.cornerRadius = 12
        container.layer.masksToBounds = true
        container.layer.borderWidth = 1.25
        container.layer.borderColor = UIColor.systemGray4.cgColor
    }
}
