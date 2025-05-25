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
    static var _pirateBlue: UIColor {
        UIColor(resource: .pirateBlue)
    }
    
    /// 강조나 하이라이트에 사용되는 동적 연한 파란색입니다.
    static var _pirateLightBlue: UIColor {
        UIColor(resource: .pirateLightBlue)
    }
    
    /// 보조적인 강조 요소에 사용되는 동적 중간 파란색입니다.
    static var _pirateDarkBlue: UIColor {
        UIColor(resource: .pirateDarkBlue)
    }
}



#Preview(traits: .fixedLayout(width: 300, height: 300)) {
    VStack {
        Color(uiColor: ._pirateBlue)
        Color(uiColor: ._pirateLightBlue)
        Color(uiColor: ._pirateDarkBlue)
    }
}
