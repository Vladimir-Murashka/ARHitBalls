//
//  FruitsTextureEnum.swift
//  ARHitBalls
//
//  Created by Swift Learning on 28.09.2022.
//

import UIKit

enum FruitsTextureEnum: String, CaseIterable {
    case apple
    case cabbage
    case lime
    case melon
    case orange
    case watermelon
    
    var image: UIImage? {
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
}
