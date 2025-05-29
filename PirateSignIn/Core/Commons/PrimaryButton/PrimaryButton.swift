//
//  PrimaryButton.swift
//  PirateSignIn
//
//  Created by 김건우 on 5/24/25.
//

import UIKit

protocol PrimaryButtonDelegate: AnyObject {

    /// PrimaryButton이 탭되었을 때 호출됩니다.
    /// - Parameter button: 탭된 PrimaryButton 인스턴스
    func primaryButtonDidTapped(_ button: PrimaryButton)
}

/// 커스터마이징 가능한 버튼을 제공하는 뷰입니다.
/// Interface Builder에서 설정할 수 있는 다양한 속성을 지원하며, UIButton을 감싸는 뷰입니다.
@IBDesignable
final class PrimaryButton: NibView {
    
    /// 버튼에 표시할 텍스트입니다.
    @IBInspectable var title: String? {
        didSet { buttonConfiguration(\.title, for: title) }
    }
    
    /// 버튼에 적용할 PirateFont의 정수형 rawValue입니다.
    /// - Note: 내부적으로 해당 값에 맞는 UIFont로 변환하여 attributedTitle에 적용됩니다.
    @IBInspectable var titleFont: Int = 0 {
        didSet { buttonConfiguration(\.attributedTitle, for: attributedString(font: titleFont)) }
    }
    
    /// 버튼의 배경 색상입니다.
    @IBInspectable var baseBackgroundColor: UIColor? {
        didSet { buttonConfiguration(\.baseBackgroundColor, for: baseBackgroundColor) }
    }
    
    /// 버튼의 텍스트 색상입니다.
    @IBInspectable var baseForegroundColor: UIColor? {
        didSet { buttonConfiguration(\.baseForegroundColor, for: baseForegroundColor) }
    }
    
    /// 버튼의 모서리 둥글기입니다.
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet { buttonConfiguration(\.background.cornerRadius, for: cornerRadius) }
    }

    /// 버튼의 활성화 여부를 나타냅니다.
    @IBInspectable var isEnabled: Bool = true {
        didSet { setEnabled(isEnabled) }
    }

    /// 실제 동작을 수행하는 UIButton 아웃렛입니다.
    @IBOutlet var button: UIButton!
    
    /// 버튼의 탭 이벤트를 처리할 델리게이트 객체입니다.
    weak var delegate: PrimaryButtonDelegate?

    /// 코드로 초기화할 때 호출되는 초기화 메서드입니다.
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadFromNib(owner: self)
    }

    /// 스토리보드 또는 XIB로 초기화할 때 호출되는 초기화 메서드입니다.
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadFromNib(owner: self)
    }

    /// 버튼이 탭되었을 때 호출되는 액션 메서드입니다.
    /// 델리게이트에게 탭 이벤트를 전달합니다.
    @IBAction func buttonTapped(_ sender: Any) {
        delegate?.primaryButtonDidTapped(self)
    }
}

extension PrimaryButton {
    
    /// 버튼의 활성화 상태에 따라 색상 및 투명도를 조정합니다.
    /// - Parameter enabled: 활성화 여부를 나타내는 불리언 값입니다.
    func setEnabled(_ enabled: Bool) {
        guard let button = button else { return }
        button.apply {
            $0.isEnabled = enabled
            $0.withConfiguration(
                \.baseBackgroundColor,
                 for: enabled ? ._pirateBlue : .systemGray
            )
            $0.alpha = enabled ? 1 : 0.75
        }
    }

    /// UIButton.Configuration에 특정 값을 설정하는 헬퍼 메서드입니다.
    /// - Parameters:
    ///   - keyPath: 설정할 Configuration의 KeyPath입니다.
    ///   - value: 적용할 값입니다.
    private func buttonConfiguration<Value>(
        _ keyPath: WritableKeyPath<UIButton.Configuration, Value>,
        for value: Value
    ) {
        guard let button = button else { return }
        button.withConfiguration(keyPath, for: value)
    }
    
    /// 주어진 폰트 rawValue에 해당하는 UIFont로부터 NSAttributedString을 생성합니다.
    /// - Parameter rawValue: PirateFont의 정수값입니다.
    /// - Returns: 지정된 폰트가 적용된 AttributedString 객체입니다.
    private func attributedString(font rawValue: Int) -> AttributedString {
        AttributedString(
            title ?? "",
            attributes: AttributeContainer(
                [.font: SignInFont.get(rawValue)]
            )
        )
    }
}
