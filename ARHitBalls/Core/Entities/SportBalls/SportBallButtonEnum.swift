//
//  SportBallButtonEnum.swift
//  ARHitBalls
//
//  Created by Swift Learning on 28.09.2022.
//

import UIKit

enum SportBallButtonEnum: String, CaseIterable {
    case basketball
    case golf
    case magic
    case soccer
    case tenis
    case volleyball
    
    var imageName: String {
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
