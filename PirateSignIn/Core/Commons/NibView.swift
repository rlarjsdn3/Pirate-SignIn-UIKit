//
//  CoreView.swift
//  PirateSignIn
//
//  Created by 김건우 on 5/24/25.
//

import UIKit

/// nib을 통해 로드되는 UIView의 공통 기반 클래스로, UI 구성 및 속성 설정을 위한 템플릿 메서드를 제공합니다.
class NibView: UIView, NibLoadable {

    /// 코드 기반 초기화 메서드입니다.
    /// - Parameter frame: 뷰의 프레임(rect) 정보입니다.
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    /// Interface Builder에서 인스턴스가 생성될 때 호출되는 초기화 메서드입니다.
    /// - Parameter aDecoder: 디코더 객체로, nib 또는 storyboard에서 뷰를 로드할 때 제공됩니다.
    /// - Important: nib으로 뷰를 불러와야 하는 경우 이 이니셜라이저에서 반드시 `loadFromNib(owner:)` 메서드를 명시적으로 호출해야 합니다.
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        setupUI()
        setupAttributes()
    }

    /// 하위 클래스에서 UI 구성 작업을 구현하기 위한 메서드입니다.
    /// - Note: 서브클래스에서 오버라이드하여 사용하세요.
    func setupUI() { }

    /// 하위 클래스에서 속성 설정 작업을 구현하기 위한 메서드입니다.
    /// - Note: 서브클래스에서 오버라이드하여 사용하세요.
    func setupAttributes() { }
}
