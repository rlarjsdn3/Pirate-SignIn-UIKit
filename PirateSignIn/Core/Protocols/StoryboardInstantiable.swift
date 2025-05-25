//
//  StoryboardInstantiable.swift
//  PirateSignIn
//
//  Created by 김건우 on 5/24/25.
//

import UIKit

/// 스토리보드에서 초기 뷰 컨트롤러를 인스턴스화할 수 있는 타입을 정의하는 프로토콜입니다.
protocol StoryboardInstantiable {
    /// 연결된 스토리보드 파일의 이름입니다. 기본적으로 타입 이름과 동일합니다.
    static var storyboardName: String { get }

    /// 스토리보드에서 초기 뷰 컨트롤러를 인스턴스화하여 반환합니다.
    static func instantiateInitialViewController() -> Self
}

extension StoryboardInstantiable where Self: UIViewController {

    /// 뷰 컨트롤러 클래스 이름과 동일한 스토리보드 이름을 반환합니다.
    static var storyboardName: String {
        String(describing: self)
    }

    /// 현재 뷰 컨트롤러에 해당하는 스토리보드 객체를 반환합니다.
    static var storyboard: UIStoryboard {
        let bundle = Bundle(for: Self.self)
        return UIStoryboard(name: storyboardName, bundle: bundle)
    }

    /// 연결된 스토리보드에서 초기 뷰 컨트롤러를 인스턴스화하여 반환합니다.
    /// - Returns: 스토리보드에서 생성된 뷰 컨트롤러 인스턴스
    /// - Note: 초기 뷰 컨트롤러가 존재하지 않거나 타입이 일치하지 않으면 런타임 오류를 발생시킵니다.
    static func instantiateInitialViewController() -> Self {
        guard let vc = Self.storyboard.instantiateInitialViewController() as? Self else {
            fatalError("can not instantiate \(Self.self)")
        }
        return vc
    }
}
