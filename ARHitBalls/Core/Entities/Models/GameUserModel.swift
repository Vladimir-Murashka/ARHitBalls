//
//  GameUserModel.swift
//  ARHitBalls
//
//  Created by Swift Learning on 07.11.2022.
//

struct GameUserModel {
    var level: Int
    
    init(level: Int) {
        self.level = level
    }
    
    init() {
        self.level = 1
    }
}
