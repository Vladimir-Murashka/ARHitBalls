//
//  FruitsButtonEnum.swift
//  ARHitBalls
//
//  Created by Swift Learning on 28.09.2022.
//

import UIKit

enum FruitsButtonEnum: String, CaseIterable {
    case apple
    case cabbage
    case lime
    case melon
    case orange
    case watermelon
    
    var imageName: String {
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
