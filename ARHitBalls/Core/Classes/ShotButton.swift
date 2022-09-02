//
//  ShotButton.swift
//  ARHitBalls
//
//  Created by Swift Learning on 01.09.2022.
//

import UIKit

final class ShotButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupBackgroundImage(named: String) {
        let image = UIImage(named: named)
        setBackgroundImage(
            image,
            for: .normal
        )
    }
}

//MARK: - Private Methods

extension ShotButton {
    func setupButton() {
        alpha = 0.5
    }
}

