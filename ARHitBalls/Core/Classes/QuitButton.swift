//
//  QuitButton.swift
//  ARHitBalls
//
//  Created by Swift Learning on 26.09.2022.
//

import UIKit

final class QuitButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Private Methods

extension QuitButton {
    func setupButton() {
        let image = UIImage(systemName: "arrowshape.turn.up.left.circle.fill")
        setBackgroundImage(
            image,
            for: .normal
        )
        tintColor = .black
        backgroundColor = .white
        layer.cornerRadius = 15
        layer.masksToBounds = true
    }
}
