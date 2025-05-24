//
//  NibLoadable.swift
//  PirateSignIn
//
//  Created by 김건우 on 5/24/25.
//

import UIKit

protocol NibLoadable {
    ///
    static var nibName: String { get }

    ///
    func loadFromNib(owner: Any?)
}

extension NibLoadable where Self: UIView {

    ///
    static var nibName: String {
        String(describing: self)
    }

    ///
    static var nib: UINib {
        let bundle = Bundle(for: Self.self)
        return UINib(nibName: Self.nibName, bundle: bundle)
    }

    ///
    func loadFromNib(owner: Any?) {
        guard let view = Self.nib.instantiate(withOwner: owner).first as? UIView else {
            return
        }

        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(view)
    }
}
