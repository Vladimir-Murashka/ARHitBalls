//
//  MenuButton.swift
//  ARHitBalls
//
//  Created by Swift Learning on 26.09.2022.
//

import UIKit

final class MenuButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Private Methods

extension MenuButton {
    func setupButton() {
        setTitleColor(
            .white,
            for: .normal
        )
        layer.cornerRadius = 12
        layer.masksToBounds = true
    }
}
