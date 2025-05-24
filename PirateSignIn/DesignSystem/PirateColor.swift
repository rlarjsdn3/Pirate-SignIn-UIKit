//
//  PirateColor.swift
//  PirateSignIn
//
//  Created by 김건우 on 5/24/25.
//

import UIKit
import SwiftUI

extension UIColor {
    
    /// 브랜드의 기본 색상으로 사용되는 동적 파란색입니다.
    static var pirateBlue: UIColor {
        UIColor(
            light: UIColor(r: 8, g: 58, b: 127),
            dark:  UIColor(r: 130, g: 170, b: 255)
        )
    }
    
    /// 강조나 하이라이트에 사용되는 동적 연한 파란색입니다.
    static var pirateLightBlue: UIColor {
        UIColor(
            light: UIColor(r: 65, g: 166, b: 210),
            dark:  UIColor(r: 140, g: 200, b: 255)
        )
    }
    
    /// 보조적인 강조 요소에 사용되는 동적 중간 파란색입니다.
    static var pirateDarkBlue: UIColor {
        UIColor(
            light: UIColor(r: 41, g: 133, b: 221),
            dark:  UIColor(r: 100, g: 180, b: 255)
        )
    }
}



#Preview {
    VStack {
        Color(uiColor: .pirateBlue)
        Color(uiColor: .pirateLightBlue)
        Color(uiColor: .pirateDarkBlue)
    }
}
