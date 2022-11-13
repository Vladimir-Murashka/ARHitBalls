//
//  UICollectionView.swift
//  ARHitBalls
//
//  Created by Swift Learning on 13.11.2022.
//

import UIKit

extension UICollectionView {
    func customRegister<T: UICollectionViewCell>(_ cellType: T.Type) {
        register(
            cellType,
            forCellWithReuseIdentifier: cellType.reuseId
        )
    }
    
    func customDequeueReusableCell<T: UICollectionViewCell>(
        _ cellType: T.Type,
        indexPath: IndexPath
    ) -> T {
        guard let cell = dequeueReusableCell(
            withReuseIdentifier: cellType.reuseId,
            for: indexPath
        ) as? T else {
            fatalError("\(String(describing: T.self)) not found")
        }
        return cell
    }
}
