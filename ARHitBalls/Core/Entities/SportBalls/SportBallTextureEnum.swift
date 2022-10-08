//
//  SportBallTextureEnum.swift
//  ARHitBalls
//
//  Created by Swift Learning on 28.09.2022.
//

import UIKit

enum SportBalls: String, CaseIterable {
    case basketball
    case golf
    case magic
    case soccer
    case tenis
    case volleyball
    
    var image: UIImage? {
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
}
