//
//  InfoLabel.swift
//  ARHitBalls
//
//  Created by Swift Learning on 27.09.2022.
//

import UIKit

final class InfoLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Private Methods

extension InfoLabel {
    func setupLabel() {
        textAlignment = .center
        textColor = .white
        layer.cornerRadius = 8
        layer.masksToBounds = true
        backgroundColor = .black
    }
}
