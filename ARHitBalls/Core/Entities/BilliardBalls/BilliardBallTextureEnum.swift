//
//  BilliardBallTextureEnum.swift
//  ARHitBalls
//
//  Created by Swift Learning on 28.09.2022.
//

import UIKit

enum BilliardBallTextureEnum: String, CaseIterable {
    case billiard1
    case billiard3
    case billiard4
    case billiard6
    case billiard10
    case billiard12
    
    var image: UIImage? {
        switch self {
        case .billiard1:
            return UIImage(named: "billiard1Texture.jpg")
        case .billiard3:
            return UIImage(named: "billiard3Texture.jpg")
        case .billiard4:
            return UIImage(named: "billiard4Texture.jpg")
        case .billiard6:
            return UIImage(named: "billiard6Texture.jpg")
        case .billiard10:
            return UIImage(named: "billiard10Texture.jpg")
        case .billiard12:
            return UIImage(named: "billiard12Texture.jpg")
        }
    }
}
