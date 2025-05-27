//
//  SignUpViewController.swift
//  PirateSignIn
//
//  Created by 김건우 on 5/24/25.
//

import UIKit

final class SignUpViewController: CoreViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameField: SignInTextField!
    @IBOutlet weak var emailField: SignInTextField!
    @IBOutlet weak var passwordField: SignInTextField!
    @IBOutlet weak var haveAccountLabel: HaveAccountButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        becomeFirstResponderIfNeeded()
        nameField.inputField.delegate = self
        emailField.inputField.delegate = self
        passwordField.inputField.delegate = self
        haveAccountLabel.delegate = self
    }

    override func setupAttributes() {
        super.setupAttributes()

        imageView.apply {
            $0.tintColor = ._pirateBlue
            $0.setImage(withAlwaysTemplate: "steering-wheel")
        }
    }

    private func becomeFirstResponderIfNeeded() {
        if nameField.inputField.canBecomeFirstResponder {
            nameField.inputField.becomeFirstResponder()
        }
    }

    @IBAction func didTapForgotPassword(_ sender: Any) {
        // Forgot Password 버튼 선택하면 콘솔에 로그 출력(로그 문구는 자유)
    }
}


extension SignUpViewController: UITextFieldDelegate {

    /**
     - 화면이 표시되는 시점에 Name 필드에 포커스
     - Name 필드에서 Next 키 터치하면 Email 필드로 포커스 이동
     - Email 필드에서 Next 키 터치하면 Password 필드로 포커스 이동
     - Password 필드에서 Done 키 터치하면 Log in 버튼과 연결된 액션 실행
     - Log in 버튼을 터치하면 입력한 이메일과 비밀번호를 콘솔에 출력
     - SNS 로그인 버튼은 기능없이 배치만 구현
     - Forgot Password 버튼 선택하면 콘솔에 로그 출력(로그 문구는 자유)
     - 이름이 2 ~ 5자 사이로 입력되었고, Email이 올바른 포멧으로 입력되었고, 비밀번호가 아래와 같은 형식인 경우에만 Log In 버튼을 활성화
         - 길이 : 6 ~ 20
         - 대소문자 하나 이상 포함
         - 숫자 하나 이상 포함
         - 특수문자 하나 이상 포함
     - 텍스트 필드와 버튼의 너비는 디바이스 너비에 따라 늘어나거나 줄어들어야 함
     */
}

extension SignUpViewController: HaveAccountButtonDelegate {

    func haveAccountDidTapLoginButton(_ button: UIButton) {
        dismiss(animated: true)
    }
}
