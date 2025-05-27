//
//  OnboardingViewController.swift
//  PirateSignIn
//
//  Created by 김건우 on 5/24/25.
//

import UIKit

final class OnboardingViewController: CoreViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var getStartedButton: PrimaryButton!
    @IBOutlet weak var loginButton: HaveAccountButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        loginButton.delegate = self
    }

    override func setupAttributes() {
        super.setupAttributes()

        imageView.apply {
            $0.tintColor = ._pirateBlue
            $0.setImage(withAlwaysTemplate: "steering-wheel")
        }
    }
}

extension OnboardingViewController: HaveAccountButtonDelegate {

    func haveAccountDidTapLoginButton(_ button: UIButton) {
        performSegue(withIdentifier: "OnboardingToSignIn", sender: nil)
    }
}
