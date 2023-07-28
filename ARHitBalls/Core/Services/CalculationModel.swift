//
//  CalculationModel.swift
//  spravochnik_spz
//
//  Created by Natalia Shevaldina on 20.05.2023.
//

import Foundation

struct LevelModel: Codable {
    let userID: String
    let level: Level
}

struct Level: Codable {
    let level: Int
}
