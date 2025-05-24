//
//  PrimaryButton.swift
//  PirateSignIn
//
//  Created by 김건우 on 5/24/25.
//

import UIKit

protocol SampleButtonViewDelegate: AnyObject {
    func sampleButtonTapped(_ button: SampleButton)
}

@IBDesignable
final class SampleButton: CoreView {

    @IBOutlet private var button: UIButton!

    weak var delegate: SampleButtonViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadFromNib(owner: self)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadFromNib(owner: self)
    }

    @IBAction func buttonTapped(_ sender: Any) {
        delegate?.sampleButtonTapped(self)
    }
}
