//
//  UIStackView.swift
//  ARHitBalls
//
//  Created by Swift Learning on 20.08.2022.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach {
            addArrangedSubview($0)
        }
    }
}
