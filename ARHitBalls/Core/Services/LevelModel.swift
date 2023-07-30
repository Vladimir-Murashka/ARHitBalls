//
//  LevelModel.swift
//  ARHitBalls
//
//  Created by Максим Косников on 30.07.2023.
//

import Foundation

struct LevelModel: Codable {
    let userID: String
    let level: Level
}

struct Level: Codable {
    let level: Int
}
