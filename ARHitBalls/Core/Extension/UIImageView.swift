//
//  UIImageView.swift
//  ARHitBalls
//
//  Created by Swift Learning on 11.11.2022.
//

import UIKit

extension UIImageView {
    func applyBlurEffect() {
        let blurEffect = UIBlurEffect(style: .prominent)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(blurEffectView)
    }
}
