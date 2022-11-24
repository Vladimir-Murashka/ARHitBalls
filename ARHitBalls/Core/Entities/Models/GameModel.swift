//
//  GameValuesModel.swift
//  ARHitBalls
//
//  Created by Swift Learning on 07.11.2022.
//

struct GameModel {
    var level: Int
    var time: Double
    var kits: [GameKitModel]
    
    init(level: Int) {
        self.level = level
        self.time = Double(level * 20)
        self.kits = GameModel.fetchGameKits(level: level)
    }
    
    mutating func levelUP() {
        level += 1
        time = Double(level * 20)
        kits = GameModel.fetchGameKits(level: level)
    }
    
    private static func fetchGameKits(level: Int) -> [GameKitModel] {
        var result: [GameKitModel] = []
        KitType.allCases.forEach {
            let isLock = (level % 10 == 0)
            ? (level - 1) / 10 >= $0.rawValue
            : level / 10 >= $0.rawValue
            
            let newKit = GameKitModel(
                type: $0,
                isLocked: isLock
            )
            result.append(newKit)
        }
        return result
    }
}

struct GameKitModel {
    let type: KitType
    let isLocked: Bool
}
