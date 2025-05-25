//
//  UIButton+Extension.swift
//  PirateSignIn
//
//  Created by 김건우 on 5/24/25.
//

import UIKit

extension UIButton {

    /// 현재 버튼 상태에 맞게 업데이트된 구성(Configuration) 객체를 반환합니다.
    /// - Returns: 버튼의 현재 상태에 기반해 업데이트된 `UIButton.Configuration` 객체. 구성 값이 없는 경우 `nil`을 반환합니다.
    @available(iOS 15.0, *)
    func resolvedConfiguration() -> UIButton.Configuration? {
        self.configuration?.updated(for: self)
    }

    /// 지정한 구성 속성 값을 설정하고, 버튼에 해당 구성을 적용합니다.
    /// - Parameters:
    ///   - keyPath: 수정할 구성 속성의 키 경로(`WritableKeyPath`)
    ///   - value: 지정한 키 경로에 설정할 값
    /// - Returns: 변경된 구성을 적용한 버튼 객체(`self`)를 반환합니다. 체이닝에 활용할 수 있습니다.
    /// - Note: 버튼의 구성(configuration)이 없는 경우 런타임 오류가 발생합니다.
    @available(iOS 15.0, *)
    @discardableResult
    func withConfiguration<Value>(
        _ keyPath: WritableKeyPath<UIButton.Configuration, Value>,
        for value: Value
    ) -> UIButton {
        guard var config = self.resolvedConfiguration() else {
            fatalError("\(self) configuration not resolved")
        }
        config[keyPath: keyPath] = value
        self.configuration = config
        return self
    }
}
