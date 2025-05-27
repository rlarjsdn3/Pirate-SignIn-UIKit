//
//  UIView+Do.swift
//  PirateSignIn
//
//  Created by 김건우 on 5/24/25.
//

import UIKit

protocol Apply { }

extension Apply {

    /// 뷰를 구성하기 위한 설정 핸들러를 받아 즉시 구성 작업을 수행합니다.
    /// - Parameter configurationHandler: 현재 뷰(Self)를 인자로 받아 원하는 설정을 적용하는 클로저입니다.
    /// - Returns: 설정이 적용된 자기 자신(Self)을 반환하여 체이닝을 가능하게 합니다.
    @discardableResult
    @inlinable func apply(_ configurationHandler: (Self) -> Void) -> Self {
        configurationHandler(self)
        return self
    }
}


extension UIView: Apply { }
