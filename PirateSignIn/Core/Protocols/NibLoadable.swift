//
//  NibLoadable.swift
//  PirateSignIn
//
//  Created by 김건우 on 5/24/25.
//

import UIKit

/// Nib 파일로부터 뷰를 로드할 수 있는 타입을 정의하는 프로토콜입니다.
protocol NibLoadable {
    /// 연결된 nib 파일의 이름입니다. 기본적으로 타입 이름과 동일합니다.
    static var nibName: String { get }

    /// nib 파일에서 뷰를 로드합니다.
    /// - Parameter owner: nib 파일의 소유자 객체입니다. 일반적으로 `self`를 전달합니다.
    func loadFromNib(owner: Any?)
}

extension NibLoadable where Self: UIView {

    /// 뷰 클래스와 동일한 이름의 nib 파일 이름을 반환합니다.
    static var nibName: String {
        String(describing: self)
    }

    /// 해당 뷰와 연결된 nib 객체를 반환합니다.
    static var nib: UINib {
        let bundle = Bundle(for: Self.self)
        return UINib(nibName: Self.nibName, bundle: bundle)
    }

    /// nib 파일에서 뷰를 로드하고, 현재 뷰에 하위 뷰로 추가합니다.
    /// - Parameter owner: nib의 소유자 객체로, 일반적으로 `self`를 전달합니다.
    /// - Note: 로드된 뷰는 현재 뷰의 크기에 맞춰 프레임이 설정되고, 리사이징 마스크도 적용됩니다.
    func loadFromNib(owner: Any?) {
        guard let view = Self.nib.instantiate(withOwner: owner).first as? UIView else {
            fatalError("can not load nib: \(self)")
        }

        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(view)
    }
}
