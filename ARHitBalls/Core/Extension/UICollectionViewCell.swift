//
//  UICollectionViewCell.swift
//  ARHitBalls
//
//  Created by Swift Learning on 13.11.2022.
//

import UIKit

extension UICollectionViewCell {
    static var reuseId: String {
        return String(describing: Self.self)
    }
}
