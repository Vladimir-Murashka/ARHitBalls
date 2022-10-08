//
//  SportBallTextureEnum.swift
//  ARHitBalls
//
//  Created by Swift Learning on 28.09.2022.
//

import UIKit

enum SportBalls: Int, CaseIterable, ARObjectable {
    case basketball
    case golf
    case magic
    case soccer
    case tenis
    case volleyball
    
    var shot: ARObjectModel {
        return ARObjectModel(
            nodeName: nodeName,
            buttonImageName: buttonImage,
            textureImage: textureImage ?? UIImage()
        )
    }
    
    private var nodeName: String {
        switch self {
        case .basketball:
            return "basketball"
        case .golf:
            return "golf"
        case .magic:
            return "magic"
        case .soccer:
            return "soccer"
        case .tenis:
            return "tenis"
        case .volleyball:
            return "volleyball"
        }
    }
    
    private var textureImage: UIImage? {
        switch self {
        case .basketball:
            return UIImage(named: "basketballTexture.jpg")
        case .golf:
            return UIImage(named: "golfTexture.jpg")
        case .magic:
            return UIImage(named: "magicTexture.jpg")
        case .soccer:
            return UIImage(named: "soccerTexture.jpg")
        case .tenis:
            return UIImage(named: "tenisTexture.jpg")
        case .volleyball:
            return UIImage(named: "volleyballTexture.jpg")
        }
    }
    
    private var buttonImage: String {
        switch self {
        case .basketball:
            return "basketballButton"
        case .golf:
            return "golfButton"
        case .magic:
            return "magicButton"
        case .soccer:
            return "soccerButton"
        case .tenis:
            return "tenisButton"
        case .volleyball:
            return "volleyballButton"
        }
    }
}
