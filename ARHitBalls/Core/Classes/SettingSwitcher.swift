//
//  SettingSwitcher.swift
//  ARHitBalls
//
//  Created by Swift Learning on 27.09.2022.
//

import UIKit

final class SettingSwitcher: UISwitch {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSwitcher()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Private Methods

extension SettingSwitcher {
    func setupSwitcher() {
        layer.cornerRadius = 15
        layer.masksToBounds = true
        backgroundColor = .black
    }
}
