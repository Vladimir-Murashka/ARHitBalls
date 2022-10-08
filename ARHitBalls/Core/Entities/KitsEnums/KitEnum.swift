//
//  KitEnum.swift
//  ARHitBalls
//
//  Created by Swift Learning on 27.09.2022.
//

import UIKit

enum KitEnum: String, CaseIterable {
    case planets
    case fruits
    case billiardBalls
    case sportBalls
    
    var imageName: String {
        switch self {
        case .planets:
            return "planets"
        case .fruits:
            return "fruits"
        case .billiardBalls:
            return "billiardBalls"
        case .sportBalls:
            return "sportBalls"
        }
    }
}
