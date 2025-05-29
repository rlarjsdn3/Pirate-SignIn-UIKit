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
    @IBOutlet weak var logInButton: PrimaryButton!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var haveAccountLabel: HaveAccountButton!
    @IBOutlet weak var orConnectLabel: OrConnectWithLabel!

    @IBOutlet weak var centerYConstraint: NSLayoutConstraint!
    
    private var isValidName: Bool = false
    private var isValidPassword: Bool = false
    private var isValidEmailAddress: Bool = false
    private var isShowKeyboard: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        hideKeyboardWhenTappedAround(view)
        registerKeyboardNotification()
        registerTextFieldDidChangeNotification()
        becomeFirstResponderIfNeeded(nameField.inputField)
        nameField.inputField.delegate = self
        emailField.inputField.delegate = self
        passwordField.inputField.delegate = self
        logInButton.delegate = self
        haveAccountLabel.delegate = self
        orConnectLabel.delegate = self
    }

    override func setupAttributes() {
        super.setupAttributes()

        imageView.apply {
            $0.tintColor = ._pirateBlue
            $0.setImage(withAlwaysTemplate: "steering-wheel")
        }

        nameField.inputField.apply {
            $0.autocorrectionType = .no
            $0.autocapitalizationType = .none
            $0.spellCheckingType = .no
            $0.smartDashesType = .no
            $0.smartQuotesType = .no
            $0.textContentType = .nickname
            $0.keyboardType = .default
            $0.returnKeyType = .next
            $0.delegate = self
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

    private func registerTextFieldDidChangeNotification() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleTextFieldChange(_:)),
            name: UITextField.textDidChangeNotification,
            object: nil
        )
    }

    @objc private func handleTextFieldChange(_ notification: Notification) {
        guard let textField = notification.object as? UITextField else { return }

        switch textField {
        case nameField.inputField:
            if let text = textField.text {
                isValidName = text.checkIsValidName
            }

        case emailField.inputField:
            if let text = textField.text {
                isValidEmailAddress = text.checkIsVaildEmailAddress
            }

        case passwordField.inputField:
            if let text = textField.text {
                isValidPassword = text.checkIsValidPassword
            }

        default:
            break
        }

        isValidEmailAddressPasswordAndName {
            self.logInButton.setEnabled(true)
        } isNotValid: {
            self.logInButton.setEnabled(false)
        }
    }

    private func registerKeyboardNotification() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    @objc private func keyboardWillShow(_ notification: Notification) {
        adjustKeyboardConstraint(true, notification: notification)
    }

    @objc private func keyboardWillHide(_ notification: Notification) {
        adjustKeyboardConstraint(false, notification: notification)
    }

    private func adjustKeyboardConstraint(
        _ show: Bool,
        notification: Notification
    ) {
        guard
            let userInfo = notification.userInfo,
            let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
            let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
        else { return }

        let keyboardHeightFromBottom = keyboardFrame.height
        let forgotPasswordButtonHeightFromBottom = view.frame.height - forgotPasswordButton.frame.maxY

        if show {
            // 키보드가 버튼을 가릴 경우에만 버튼을 올림 (iPhone 16 Pro Max에서 올리지 않음)
            if keyboardHeightFromBottom > forgotPasswordButtonHeightFromBottom {
                centerYConstraint.constant = 120
            } else {
                // 이미 키보드가 올라와 있으면 무시 (텍스트필드가 바뀔 때, 짧게 뷰가 이동하는 현상 방지)
                if isShowKeyboard { return }
                centerYConstraint.constant = 150
            }
        } else {
            // 키보드가 사라졌을 때는 항상 원래 위치로 복귀
            centerYConstraint.constant = 150
        }

        // 키보드 보기 상태 갱신
        isShowKeyboard = show

        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }
}

extension SignUpViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nameField.inputField:
            becomeFirstResponderIfNeeded(emailField.inputField)
            return true
        case emailField.inputField:
            becomeFirstResponderIfNeeded(passwordField.inputField)
            return true
        case passwordField.inputField:
            isValidEmailAddressPasswordAndName {
                handleLogIn()
                resignFirstResponderIfNeeded(passwordField.inputField)
            }
            return true
        default:
            return true
        }
    }
}

extension SignUpViewController: PrimaryButtonDelegate {

    func primaryButtonDidTapped(_ button: PrimaryButton) {
        isValidEmailAddressPasswordAndName {
            handleLogIn()
        }
    }

    private func handleLogIn() {
        print(
            "Name: \(nameField.inputField.text),",
            "Email: \(emailField.inputField.text),",
            "Password: \(passwordField.inputField.text)"
        )
    }

    private func isValidEmailAddressPasswordAndName(
        _ isValid: () -> Void,
        isNotValid: (() -> Void)? = nil
    ) {
        if isValidEmailAddress && isValidPassword && isValidName {
            isValid()
        } else {
            isNotValid?()
        }
    }
}

extension SignUpViewController: HaveAccountButtonDelegate {

    func haveAccountDidTapLoginButton(_ button: UIButton) {
        dismiss(animated: true)
    }
}

extension SignUpViewController: OrConnectWithLabelDelegate {

    func orConnectWithLabel(
        _ button: SocialSignInButton,
        didTapSocialSignInButton signInType: SocialSignInButton.SignInType
    ) {
        dismiss(animated: true)
    }
}
