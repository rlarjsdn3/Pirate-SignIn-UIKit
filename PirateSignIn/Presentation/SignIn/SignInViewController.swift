//
//  SignInViewController.swift
//  PirateSignIn
//
//  Created by 김건우 on 5/24/25.
//

import UIKit

final class SignInViewController: CoreViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var emailField: SignInTextField!
    @IBOutlet weak var passwordField: SignInTextField!
    @IBOutlet weak var haveAccountLabel: HaveAccountButton!
    @IBOutlet weak var logInButton: PrimaryButton!
    @IBOutlet weak var orConnectLabel: OrConnectWithLabel!

    private var isValidPassword: Bool = false
    private var isValidEmailAddress: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        hideKeyboardWhenTappedAround()
        becomeFirstResponderIfNeeded(emailField.inputField)
        emailField.inputField.delegate = self
        passwordField.inputField.delegate = self
        orConnectLabel.delegate = self
        logInButton.delegate = self
        haveAccountLabel.delegate = self
    }

    override func setupAttributes() {
        super.setupAttributes()

        imageView.apply {
            $0.tintColor = ._pirateBlue
            $0.setImage(withAlwaysTemplate: "steering-wheel")
        }
        
        emailField.inputField.apply {
            $0.autocorrectionType = .no
            $0.autocapitalizationType = .none
            $0.spellCheckingType = .no
            $0.smartDashesType = .no
            $0.smartQuotesType = .no
            $0.textContentType = .emailAddress
            $0.keyboardType = .emailAddress
            $0.returnKeyType = .next
            $0.delegate = self
        }
        
        passwordField.inputField.apply {
            $0.autocorrectionType = .no
            $0.autocapitalizationType = .none
            $0.spellCheckingType = .no
            $0.smartDashesType = .no
            $0.smartQuotesType = .no
            $0.textContentType = .password
            $0.returnKeyType = .done
            $0.delegate = self
        }
    }
    
    @IBAction func didTapForgotPassword(_ sender: Any) {
        print(#function)
    }
}

/**
 - 화면이 표시되는 시점에 Email 필드에 포커스
 - Email 필드에서 Next 키 터치하면 Password 필드로 포커스 이동
 - Password 필드에서 Done 키 터치하면 Log in 버튼과 연결된 액션 실행
 - Log in 버튼을 터치하면 입력한 이메일과 비밀번호를 콘솔에 출력
 - SNS 로그인 버튼은 기능없이 배치만 구현
 - Forgot Password 버튼 선택하면 콘솔에 로그 출력(로그 문구는 자유)
 - Email이 올바른 포멧으로 입력되었고 비밀번호가 아래와 같은 형식인 경우에만 Log In 버튼을 활성화
     - 길이 : 6 ~ 20
     - 대소문자 하나 이상 포함
     - 숫자 하나 이상 포함
     - 특수문자 하나 이상 포함
 - 텍스트 필드와 버튼의 너비는 디바이스 너비에 따라 늘어나거나 줄어들어야 함
 */

extension SignInViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailField.inputField:
            becomeFirstResponderIfNeeded(passwordField.inputField)
            return true
        case passwordField.inputField:
            isValidEmailAddressAndPassword {
                handleLogIn()
                resignFirstResponderIfNeeded(passwordField.inputField)
            }
            return true
        default:
            return true
        }
    }
    
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        guard
            let text = textField.text,
            let range = Range(range, in: text) // 사용자가 변경(입력/삭제/치환) 중인 문자열의 범위
        else { return false }

        let newText = text.replacingCharacters(in: range, with: string)

        switch textField {
        case emailField.inputField:
            isValidEmailAddress = newText.checkIsVaildEmailAddress
        case passwordField.inputField:
            isValidPassword = newText.checkIsValidPassword
        default:
            break
        }

        isValidEmailAddressAndPassword {
            self.logInButton.setEnabled(true)
        } isNotValid: {
            self.logInButton.setEnabled(false)
        }

        return true
    }
}

extension SignInViewController: PrimaryButtonDelegate {
    
    func primaryButtonDidTapped(_ button: PrimaryButton) {
        isValidEmailAddressAndPassword {
            handleLogIn()
        }
    }

    private func handleLogIn() {
        print(
            "Email: \(emailField.inputField.text),",
            "Password: \(passwordField.inputField.text)"
        )
    }

    private func isValidEmailAddressAndPassword(
        _ isValid: () -> Void,
        isNotValid: (() -> Void)? = nil
    ) {
        if isValidEmailAddress && isValidPassword {
            isValid()
        } else {
            isNotValid?()
        }
    }
}

extension SignInViewController: OrConnectWithLabelDelegate {

    func orConnectWithLabel(
        _ button: SocialSignInButton,
        didTapSocialSignInButton signInType: SocialSignInButton.SignInType
    ) {
        navigationController?.popViewController(animated: true)
    }
}

extension SignInViewController: HaveAccountButtonDelegate {

    func haveAccountDidTapLoginButton(_ button: UIButton) {
        performSegue(withIdentifier: "SignInToSignUp", sender: nil)
    }
}
