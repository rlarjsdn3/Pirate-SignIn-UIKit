//
//  SignInLabel.swift
//  PirateSignIn
//
//  Created by 김건우 on 5/25/25.
//

import UIKit

/// 로그인 화면 등에서 타이틀과 설명 텍스트를 함께 표시하는 커스텀 라벨 뷰입니다.
/// Nib에서 로드되며, Interface Builder를 통해 텍스트와 스타일을 설정할 수 있습니다.
final class SignInLabel: NibView {
    
    /// 타이틀에 표시할 텍스트입니다.
    @IBInspectable var title: String? {
        didSet { titleLabel.text = title }
    }
    
    /// 타이틀에 적용할 PirateFont의 rawValue입니다.
    @IBInspectable var titleFont: Int = 0 {
        didSet { titleLabel.font = SignInFont.get(titleFont) }
    }
    
    /// 타이틀 텍스트의 색상입니다.
    @IBInspectable var titleColor: UIColor? {
        didSet { titleLabel.textColor = titleColor }
    }
    
    /// 설명(서브타이틀)에 표시할 텍스트입니다.
    @IBInspectable var subtitle: String? {
        didSet { descriptionLabel.text = subtitle }
    }
    
    /// 설명에 적용할 PirateFont의 rawValue입니다.
    @IBInspectable var descriptionFont: Int = 0 {
        didSet { descriptionLabel.font = SignInFont.get(descriptionFont) }
    }
    
    /// 설명 텍스트의 색상입니다.
    @IBInspectable var descriptionColor: UIColor? {
        didSet { descriptionLabel.textColor = descriptionColor }
    }

    /// 타이틀 텍스트를 표시하는 UILabel입니다.
    @IBOutlet var titleLabel: UILabel!
    
    /// 설명 텍스트를 표시하는 UILabel입니다.
    @IBOutlet var descriptionLabel: UILabel!
    
    /// 코드로 초기화할 때 호출되는 초기화 메서드입니다.
    /// - Parameter frame: 뷰의 프레임
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadFromNib(owner: self)
    }
    
    /// Interface Builder를 통해 초기화할 때 호출되는 초기화 메서드입니다.
    /// - Parameter coder: 디코더 객체
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadFromNib(owner: self)
    }
}
