//
//  UIImageView+Extension.swift
//  PirateSignIn
//
//  Created by 김건우 on 5/26/25.
//

import UIKit

extension UIImageView {

    /// 주어진 이미지 이름을 통해 이미지를 설정하고 `.alwaysTemplate` 렌더링 모드로 지정합니다.
    /// - Parameter name: Asset Catalog에 등록된 이미지 이름
    func setImage(withAlwaysTemplate name: String) {
        self.image = UIImage(named: name)?.withRenderingMode(.alwaysTemplate)
    }

    /// 주어진 이미지 에셋을 통해 이미지를 설정하고 `.alwaysTemplate` 렌더링 모드로 지정합니다.
    /// - Parameter name: Asset Catalog에 등록된 이미지
    func setImage(withAlwaysTemplate resource: ImageResource) {
        self.image = UIImage(resource: resource).withRenderingMode(.alwaysTemplate)
    }
}
