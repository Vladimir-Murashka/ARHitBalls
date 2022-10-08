//
//  PlanetsImage.swift
//  ARHitBalls
//
//  Created by Swift Learning on 07.10.2022.
//

import UIKit

enum Planets: Int, CaseIterable, ARObjectable {
    case earth
    case jupiter
    case mars
    case mercury
    case moon
    case neptune
    
    var shot: ARObjectModel {
        return ARObjectModel(
            nodeName: nodeName,
            buttonImageName: buttonImage,
            textureImage: textureImage ?? UIImage()
        )
    }
    
    private var nodeName: String {
        switch self {
        case .earth:
            return "earth"
        case .jupiter:
            return "jupiter"
        case .mars:
            return "mars"
        case .mercury:
            return "mercury"
        case .moon:
            return "moon"
        case .neptune:
            return "neptune"
        }
    }
    
    private var textureImage: UIImage? {
        switch self {
        case .earth:
            return UIImage(named: "earth.jpg")
        case .jupiter:
            return UIImage(named: "jupiter.jpg")
        case .mars:
            return UIImage(named: "mars.jpg")
        case .mercury:
            return UIImage(named: "mercury.jpg")
        case .moon:
            return UIImage(named: "moon.jpg")
        case .neptune:
            return UIImage(named: "neptune.jpg")
        }
    }
    
    private var buttonImage: String {
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
