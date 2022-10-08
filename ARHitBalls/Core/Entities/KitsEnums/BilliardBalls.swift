//
//  BilliardBallTextureEnum.swift
//  ARHitBalls
//
//  Created by Swift Learning on 28.09.2022.
//

import UIKit

enum BilliardBalls: Int, CaseIterable, ARObjectable {
    case billiard1
    case billiard3
    case billiard4
    case billiard6
    case billiard10
    case billiard12
    
    var shot: ARObjectModel {
        return ARObjectModel(
            nodeName: nodeName,
            buttonImageName: buttonImage,
            textureImage: textureImage ?? UIImage()
        )
    }
    
    private var nodeName: String {
        switch self {
        case .billiard1:
            return "billiard1"
        case .billiard3:
            return "billiard3"
        case .billiard4:
            return "billiard4"
        case .billiard6:
            return "billiard6"
        case .billiard10:
            return "billiard10"
        case .billiard12:
            return "billiard12"
        }
    }
    
    private var textureImage: UIImage? {
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
    
    private var buttonImage: String {
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
