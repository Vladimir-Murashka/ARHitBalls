//
//  GameUserModel.swift
//  ARHitBalls
//
//  Created by Swift Learning on 07.11.2022.
//

struct GameUserModel {
    var levelValue: Int
    
    init(level: Int) {
        self.levelValue = level
    }
    
    init() {
        self.levelValue = 1
    }
}
