//
//  UIColor+Extension.swift
//  PirateSignIn
//
//  Created by 김건우 on 5/24/25.
//

import UIKit

extension UIColor {
    
    /// <#Description#>
    /// - Parameters:
    ///   - r: <#r description#>
    ///   - g: <#g description#>
    ///   - b: <#b description#>
    ///   - alpha: <#alpha description#>
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
    
    /// <#Description#>
    /// - Parameters:
    ///   - light: <#light description#>
    ///   - dark: <#dark description#>
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
