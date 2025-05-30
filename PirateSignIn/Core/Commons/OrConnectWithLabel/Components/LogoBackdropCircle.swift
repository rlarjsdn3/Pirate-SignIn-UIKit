//
//  LogoBackdropCircle.swift
//  PirateSignIn
//
//  Created by 김건우 on 5/25/25.
//

import UIKit

/// 소셜 로그인 버튼 등에 사용되는 원형 배경 이미지 뷰입니다.
/// 배경 색상과 이미지의 틴트 색을 설정할 수 있으며, 가운데 이미지가 중심 정렬되고 크기가 조절됩니다.
@IBDesignable
final class LogoBackdropCircle: NibView {

    /// 표시할 이미지의 이름입니다. 설정 시 항상 `.alwaysTemplate` 렌더링 모드로 적용됩니다.
    var imageName: String = "" {
        didSet { imageView.setImage(withAlwaysTemplate: imageName) }
    }

    /// 이미지의 틴트 색상입니다. 버튼이나 상위 뷰의 `tintColor`에 따라 반응합니다.
    override var tintColor: UIColor? {
        didSet { imageView.tintColor = tintColor }
    }

    /// 배경에 그림자나 장식 효과를 추가할 때 사용하는 뷰입니다.
    private let shadowView = UIView()

    /// 이미지가 포함될 배경 뷰입니다. 기본적으로 원형이고 밝은 파란색 배경이 적용됩니다.
    private let backdropView = UIView()

    /// 가운데 표시되는 이미지 뷰입니다.
    private let imageView = UIImageView()

    private var centerXConstraint: NSLayoutConstraint?
    private var centerYConstraint: NSLayoutConstraint?


    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(backdropView)
        backdropView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backdropView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backdropView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backdropView.topAnchor.constraint(equalTo: self.topAnchor),
            backdropView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        backdropView.apply {
            $0.layer.masksToBounds = true
            $0.backgroundColor = ._pirateLightBlue
        }

        backdropView.addSubview(shadowView)
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            shadowView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.75),
            shadowView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.75),
        ])
        centerXConstraint = shadowView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0)
        centerXConstraint?.isActive = true
        centerYConstraint = shadowView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0)
        centerYConstraint?.isActive = true

        shadowView.apply {
            $0.layer.opacity = 0.33
            $0.layer.masksToBounds = true
            $0.backgroundColor = ._pirateDarkBlue
        }

        backdropView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.55),
            imageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.55),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        shadowView.layer.cornerRadius = (frame.height / 2) * 0.75
        backdropView.layer.cornerRadius = frame.height / 2

        centerXConstraint?.constant = frame.width * 0.31
        centerYConstraint?.constant = frame.height * 0.11
    }
}


#Preview(traits: .fixedLayout(width: 122, height: 122)) {
    let logo = LogoBackdropCircle().apply {
        $0.imageName = "facebook"
        $0.tintColor = .systemBackground
    }
    return logo
}
