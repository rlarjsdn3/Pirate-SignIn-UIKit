//
//  CoreView.swift
//  PirateSignIn
//
//  Created by 김건우 on 5/24/25.
//

import UIKit

/// <#Description#>
class CoreView: UIView, NibLoadable {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    /// <#Description#>
    private func commonInit() {
        setupUI()
        setupAttributes()
    }
    
    /// <#Description#>
    func setupUI() {
    }
    
    /// <#Description#>
    func setupAttributes() {
        print("상위 뷰의 공통 속성 설정")
    }
}
