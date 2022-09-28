//
//  PlanetsTexturesEnum.swift
//  ARHitBalls
//
//  Created by Swift Learning on 27.09.2022.
//

import UIKit

enum PlanetsButton: String, CaseIterable {
    case earth
    case jupiter
    case mars
    case mercury
    case moon
    case neptune
    
    var imageName: String {
        switch self {
        case .earth:
            return "earthUIImage"
        case .jupiter:
            return "jupiterUIImage"
        case .mars:
            return "marsUIImage"
        case .mercury:
            return "mercuryUIImage"
        case .moon:
            return "moonUIImage"
        case .neptune:
            return "neptuneUIImage"
        }
    }
}
