//
//  IdentifireTextField.swift
//  ARHitBalls
//
//  Created by Swift Learning on 27.09.2022.
//

import UIKit

final class IdentifireTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Private Methods

extension IdentifireTextField {
    func setupTextField() {
        backgroundColor = .clear
        textColor = .white
        textAlignment = .center
    }
}
