//
//  LogoBackdropCircle.swift
//  PirateSignIn
//
//  Created by 김건우 on 5/25/25.
//

import UIKit

final class LogoBackdropCircle: NibView {
    
    let imageView = UIImageView()
    
    convenience init(resource: ImageResource) {
        self.init(frame: .zero)
        imageView.image = UIImage(resource: resource)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let ovalIn = UIBezierPath(ovalIn: rect)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = ovalIn.cgPath
        shapeLayer.frame = rect
        shapeLayer.fillColor = UIColor._pirateLightBlue.cgColor
        
        self.layer.addSublayer(shapeLayer)
    }
}


#Preview(traits: .fixedLayout(width: 100, height: 100)) {
    LogoBackdropCircle(
        frame: .init(
            x: 0, y: 0,
            width: 100,
            height: 100
        )
    )
}
