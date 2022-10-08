//
//  FruitsTextureEnum.swift
//  ARHitBalls
//
//  Created by Swift Learning on 28.09.2022.
//

import UIKit

enum Fruits: Int, CaseIterable, ARObjectable {
    case apple
    case cabbage
    case lime
    case melon
    case orange
    case watermelon
    
    var shot: ARObjectModel {
        return ARObjectModel(
            nodeName: nodeName,
            buttonImageName: buttonImage,
            textureImage: textureImage ?? UIImage()
        )
    }
    
    private var nodeName: String {
        switch self {
        case .apple:
            return "apple"
        case .cabbage:
            return "cabbage"
        case .lime:
            return "lime"
        case .melon:
            return "melon"
        case .orange:
            return "orange"
        case .watermelon:
            return "watermelon"
        }
    }
    
    private var textureImage: UIImage? {
        switch self {
        case .apple:
            return UIImage(named: "appleTexture.jpg")
        case .cabbage:
            return UIImage(named: "cabbageTexture.jpg")
        case .lime:
            return UIImage(named: "limeTexture.jpg")
        case .melon:
            return UIImage(named: "melonTexture.jpg")
        case .orange:
            return UIImage(named: "orangeTexture.jpg")
        case .watermelon:
            return UIImage(named: "watermelonTexture.jpg")
        }
    }
    
    private var buttonImage: String {
        switch self {
        case .apple:
            return "appleButton"
        case .cabbage:
            return "cabbageButton"
        case .lime:
            return "limeButton"
        case .melon:
            return "melonButton"
        case .orange:
            return "orangeButton"
        case .watermelon:
            return "watermelonButton"
        }
    }
}
