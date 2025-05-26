//
//  PirateFont.swift
//  PirateSignIn
//
//  Created by 김건우 on 5/25/25.
//

import UIKit

/// 앱에서 사용되는 공통 폰트를 정의하는 열거형입니다.
/// 각 케이스는 특정 UI 구성요소에 대응하는 폰트 스타일을 나타냅니다.
enum PirateFont: Int {
    
    /// 온보딩 화면의 타이틀에 사용되는 폰트
    case title      = 0
    /// 주요 버튼의 타이틀에 사용되는 폰
    case title2     = 1
    /// 텍스트 필드의 플레이스홀더에 사용되는 폰트
    case title3     = 2
    /// 로그인 및 회원가입 화면의 타이틀에 사용되는 폰트
    case headline   = 3
    /// 비밀번호 찾기 등 부가 텍스트에 사용되는 폰트
    case footnote   = 4
    /// 기타 설명 등에 사용되는 캡션 폰트
    case caption    = 5
    /// 기타 설명 등에 사용되는 볼드 캡션 폰트
    case caption2   = 6

    /// 각 케이스에 해당하는 `UIFont`를 반환합니다.
    var fount: UIFont {
        switch self {
        case .title:    return UIFont.systemFont(ofSize: 28, weight: .semibold)
        case .title2:   return UIFont.systemFont(ofSize: 20, weight: .semibold)
        case .title3:   return UIFont.systemFont(ofSize: 18)
        case .headline: return UIFont.systemFont(ofSize: 18, weight: .semibold)
        case .footnote: return UIFont.systemFont(ofSize: 14)
        case .caption:  return UIFont.systemFont(ofSize: 12)
        case .caption2: return UIFont.systemFont(ofSize: 12, weight: .bold)
        }
    }
    
    /// 주어진 정수 값에 해당하는 `UIFont`를 반환합니다.
    /// - Parameter rawValue: `PirateFont` 케이스의 정수값입니다.
    /// - Returns: 해당 케이스의 `UIFont`를 반환하며, 유효하지 않은 값일 경우 기본값인 `.title`의 폰트를 반환합니다.
    static func get(_ rawValue: Int) -> UIFont {
        if let font = PirateFont(rawValue: rawValue) {
            return font.fount
        }
        return PirateFont.title.fount
    }
}
