//
//  SocialSignInButton.swift
//  PirateSignIn
//
//  Created by 김건우 on 5/25/25.
//

import UIKit

/// 다양한 소셜 플랫폼(Facebook, Twitter, LinkedIn)에 대응하는 커스텀 로그인 버튼입니다.
/// 내부에 원형 로고 뷰(`LogoBackdropCircle`)를 포함하며, 버튼의 상태에 따라 하이라이트 효과를 적용할 수 있습니다.
final class SocialSignInButton: UIButton {

    /// 소셜 로그인 버튼의 종류를 나타내는 열거형입니다.
    enum SignInType: Int {
        /// Facebook 로그인
        case facebook
        /// Twitter 로그인
        case twitter
        /// LinkedIn 로그인
        case linkedin

        /// 각 소셜 타입에 대응하는 이미지 이름을 반환합니다.
        var fount: String {
            switch self {
            case .facebook: return "facebook"
            case .twitter:  return "twitter"
            case .linkedin: return "linkedin"
            }
        }

        /// 정수 rawValue를 기반으로 해당 소셜 타입의 이미지 이름을 반환합니다.
        /// - Parameter rawValue: 열거형의 정수 값
        /// - Returns: 해당 소셜 플랫폼의 이미지 이름
        static func get(_ rawValue: Int) -> String {
            if let type = SignInType(rawValue: rawValue) {
                return type.fount
            }
            return ""
        }
    }

    /// 버튼이 하이라이트 상태로 변경될 때 호출되어 UI를 업데이트합니다.
    override var isHighlighted: Bool {
        didSet { setHightlighted(isHighlighted) }
    }

    /// 현재 버튼이 나타내는 소셜 로그인 타입입니다.
    /// 설정 시 내부 로고 이미지가 자동으로 업데이트됩니다.
    var signInType: SignInType = .facebook {
        didSet { logoBackdropView.imageName = signInType.fount }
    }

    /// 버튼 내부의 원형 배경 로고 뷰입니다.
    private let logoBackdropView = LogoBackdropCircle()

    
    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(logoBackdropView)
        logoBackdropView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoBackdropView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            logoBackdropView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            logoBackdropView.topAnchor.constraint(equalTo: self.topAnchor),
            logoBackdropView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        logoBackdropView.isUserInteractionEnabled = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SocialSignInButton {

    private func setHightlighted(_ highlighted: Bool) {
        logoBackdropView.alpha = highlighted ? 0.5 : 1
    }
}

#Preview {
    let button = SocialSignInButton(frame: .init(x: 0, y: 0, width: 100, height: 100))
    button.tintColor = .white
    button.signInType = .facebook
    return button
}
