//
//  UIView+Do.swift
//  PirateSignIn
//
//  Created by 김건우 on 5/24/25.
//

import UIKit

protocol Apply { }

extension Apply where Self: UIView {
    
    /// <#Description#>
    /// - Parameter configurationHandler: <#configurationHandler description#>
    /// - Returns: <#description#>
    @inlinable func apply(_ configurationHandler: (Self) -> Void) {
        configurationHandler(self)
    }
}


extension UIView: Apply { }
