//
//  HaveAccountButton.swift
//  PirateSignIn
//
//  Created by 김건우 on 5/25/25.
//

import UIKit

protocol HaveAccountButtonDelegate: AnyObject {

    ///
    func haveAccountDidTapLoginButton(_ button: UIButton)
}

/// 회원가입 화면 등에서 "Do You Have an account?" 문구와 로그인 버튼을 함께 표시하는 커스텀 뷰입니다.
///
/// - Note: `signInButton`의 스타일이 `.plain`일 경우, `titleLabel?.font`를 직접 설정해도 적용되지 않을 수 있습니다.
///         이 경우 `setAttributedTitle(_:for:)` 또는 `configuration.attributedTitle`로 설정해야 합니다.
final class HaveAccountButton: NibView {

    /// 설명 라벨에 표시할 텍스트입니다.
    @IBInspectable var title: String? {
        didSet { descriptionLabel.text = title }
    }
    
    /// 설명 라벨에 적용할 PirateFont의 rawValue입니다.
    @IBInspectable var titleFont: Int = 0 {
        didSet { descriptionLabel.font = SignInFont.get(titleFont) }
    }
    
    /// 설명 라벨의 텍스트 색상입니다.
    @IBInspectable var titleColor: UIColor? {
        didSet { descriptionLabel.textColor = titleColor }
    }
    
    /// 로그인 버튼에 표시할 텍스트입니다.
    @IBInspectable var buttonTitle: String? {
        didSet { signInButton.setTitle(buttonTitle, for: .normal) }
    }
    
    /// 로그인 버튼에 적용할 PirateFont의 rawValue입니다.
    /// - Warning: `UIButton`이 `.plain` 스타일일 경우 폰트 적용이 무시될 수 있습니다.
    @IBInspectable var buttonTitleFont: Int = 0 {
        didSet {
            // 폰트가 제대로 적용되지 않을 경우, NSAttributedString 방식으로 설정하는 것을 권장합니다.
            signInButton.titleLabel?.font = SignInFont(rawValue: buttonTitleFont)?.fount
        }
    }
    
    /// 설명 라벨 아웃렛입니다.
    @IBOutlet weak var descriptionLabel: UILabel!
    
    /// 로그인 버튼 아웃렛입니다.
    @IBOutlet weak var signInButton: UIButton!

    ///
    weak var delegate: (any HaveAccountButtonDelegate)?

    /// 코드로 초기화할 때 호출되는 초기화 메서드입니다.
    /// - Parameter frame: 뷰의 프레임
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadFromNib(owner: self)
    }
    
    /// Interface Builder에서 초기화할 때 호출되는 초기화 메서드입니다.
    /// - Parameter coder: NSCoder 객체
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadFromNib(owner: self)

        setupSignInButton()
    }

    private func setupSignInButton() {
        signInButton.addTarget(
            self,
            action: #selector(didTapLoginButton),
            for: .touchUpInside
        )
    }

    @objc private func didTapLoginButton(_ sender: UIButton) {
        delegate?.haveAccountDidTapLoginButton(sender)
    }
}
