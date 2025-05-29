//
//  CoreViewController.swift
//  PirateSignIn
//
//  Created by 김건우 on 5/24/25.
//

import UIKit

/// 공통 UI 구성 로직과 속성 설정을 제공하는 UIViewController의 기반 클래스입니다.
/// `StoryboardInstantiable`을 채택하여 스토리보드로부터 초기 뷰 컨트롤러를 쉽게 인스턴스화할 수 있습니다.
class CoreViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupAttributes()
    }

    /// 하위 클래스에서 UI 요소를 구성하기 위한 메서드입니다.
    /// - Note: 서브클래스에서 필요한 UI 배치 및 뷰 추가 작업을 오버라이드하여 구현하세요.
    func setupUI() { }

    /// 하위 클래스에서 속성을 설정하기 위한 메서드입니다.
    /// - Note: 서브클래스에서 폰트, 색상, 상호작용 등 각종 속성 설정을 오버라이드하여 구현하세요.
    func setupAttributes() { }
}
