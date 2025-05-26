//
//  OrConnectWithLabel.swift
//  PirateSignIn
//
//  Created by 김건우 on 5/25/25.
//

import UIKit

/// `OrConnectWithLabel` 내에서 소셜 로그인 버튼이 눌렸을 때 해당 이벤트를 위임받는 델리게이트 프로토콜입니다.
protocol OrConnectWithLabelDelegate: AnyObject {

    /// 소셜 로그인 버튼이 탭되었을 때 호출됩니다.
    /// - Parameters:
    ///   - button: 탭된 `SocialSignInButton` 인스턴스
    ///   - signInType: 해당 버튼의 소셜 로그인 타입 (Facebook, Twitter, LinkedIn)
    func orConnectWithLabel(
        _ button: SocialSignInButton,
        didTapSocialSignInButton signInType: SocialSignInButton.SignInType
    )
}

@IBDesignable
final class OrConnectWithLabel: NibView {
    
    @IBOutlet weak var socialButtonStack: UIStackView!

    /// 버튼 탭 이벤트를 위임받을 델리게이트입니다.
    weak var delegate: (any OrConnectWithLabelDelegate)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadFromNib(owner: self)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadFromNib(owner: self)
        setupLabel()
    }
    
    private func setupLabel() {
        [createSocialSignInButton(.facebook),
         createSocialSignInButton(.twitter),
         createSocialSignInButton(.linkedin)].forEach {
            self.socialButtonStack.addArrangedSubview($0)
        }
    }
}

extension OrConnectWithLabel {

    @objc private func didTapSocialSignInButton(_ sender: SocialSignInButton) {
        delegate?.orConnectWithLabel(sender, didTapSocialSignInButton: sender.signInType)
    }

    private func createSocialSignInButton(_ signInType: SocialSignInButton.SignInType) -> UIButton {
        return SocialSignInButton().apply {
            $0.signInType = signInType
            $0.tintColor = .white
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.widthAnchor.constraint(equalTo: $0.heightAnchor, multiplier: 1.0).isActive = true
            $0.addTarget(self, action: #selector(didTapSocialSignInButton), for: .touchUpInside)
        }
    }
}
