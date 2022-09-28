//
//  BilliardBallButtonEnum.swift
//  ARHitBalls
//
//  Created by Swift Learning on 28.09.2022.
//

import UIKit

enum BilliardBallButtonEnum: String, CaseIterable {
    case billiard1
    case billiard3
    case billiard4
    case billiard6
    case billiard10
    case billiard12
    
    var imageName: String {
        switch self {
        case .billiard1:
            return "billiard1Button"
        case .billiard3:
            return "billiard3Button"
        case .billiard4:
            return "billiard4Button"
        case .billiard6:
            return "billiard6Button"
        case .billiard10:
            return "billiard10Button"
        case .billiard12:
            return "billiard12Button"
        }
    }
}
