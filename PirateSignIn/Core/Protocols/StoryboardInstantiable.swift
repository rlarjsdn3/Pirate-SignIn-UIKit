//
//  StoryboardInstantiable.swift
//  PirateSignIn
//
//  Created by 김건우 on 5/24/25.
//

import UIKit

protocol StoryboardInstantiable {
    ///
    static var storyboardName: String { get }

    ///
    static func instantiateInitialViewController() -> Self
}

extension StoryboardInstantiable where Self: UIViewController {

    ///
    static var storyboardName: String {
        String(describing: self)
    }

    ///
    static var storyboard: UIStoryboard {
        let bundle = Bundle(for: Self.self)
        return UIStoryboard(name: storyboardName, bundle: bundle)
    }

    ///
    static func instantiateInitialViewController() -> Self {
        guard let vc = Self.storyboard.instantiateInitialViewController() as? Self else {
            fatalError("can not instantiate \(Self.self)")
        }
        return vc
    }
}
