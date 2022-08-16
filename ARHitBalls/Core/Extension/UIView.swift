//
//  UIView.swift
//  ARHitBalls
//
//  Created by Swift Learning on 16.08.2022.
//

import UIKit

extension UIView {
    
    func myAddSubview(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
    }
    
    func addSubviews(_ views: [UIView]) {
        for view in views {
            addSubview(view)
        }
    }
    
    func myAddSubviews(_ views: [UIView]) {
        for view in views {
            myAddSubview(view)
        }
    }
    
    func myAddSubviews(_ views: UIView...) {
        for view in views {
            myAddSubview(view)
        }
    }
}
