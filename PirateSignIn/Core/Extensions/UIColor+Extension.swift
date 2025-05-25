//
//  UIColor+Extension.swift
//  PirateSignIn
//
//  Created by 김건우 on 5/24/25.
//

import UIKit

extension UIColor {
    
    /// RGB 정수 값을 기반으로 색상을 생성합니다.
    /// - Parameters:
    ///   - r: 빨간색(Red) 구성 요소 값 (0~255)
    ///   - g: 초록색(Green) 구성 요소 값 (0~255)
    ///   - b: 파란색(Blue) 구성 요소 값 (0~255)
    ///   - alpha: 투명도 값 (0.0~1.0), 기본값은 1.0입니다.
    convenience init(
        r: CGFloat,
        g: CGFloat,
        b: CGFloat,
        alpha: CGFloat = 1.0
    ) {
        self.init(
            red: r / 255.0,
            green: g / 255.0,
            blue: b / 255.0,
            alpha: alpha
        )
    }
    
    /// 다크 모드와 라이트 모드에 따라 자동으로 색상이 전환되는 UIColor를 생성합니다.
    /// - Parameters:
    ///   - light: 라이트 모드에서 사용할 색상
    ///   - dark: 다크 모드에서 사용할 색상
    convenience init(
        light: UIColor,
        dark: UIColor
    ) {
        self.init { trait in
            if trait.userInterfaceStyle == .dark {
                return dark
            } else {
                return light
            }
        }
    }
}
