//
//  GameService.swift
//  ARHitBalls
//
//  Created by Swift Learning on 15.08.2022.
//

protocol GameServiceable {
    func nextLevel()
    func getGameValue() -> GameValueModel
    func getCollection()
    func newCircleLevel(currentLevelValue: Int, currentTimeValue: Double)
}

final class GameService {
    
    private let defaultsManager: DefaultsManagerable
    var gameLevelValue: Int = 1
    var gameTimeValue: Double = 20
    private let maxLevelValue: Int = 10
    private let maxTimeValue: Double = 200
    
    init(defaultsManager: DefaultsManagerable) {
        self.defaultsManager = defaultsManager
    }
}

extension GameService: GameServiceable {
    func nextLevel() {
        var gameUser = GameUserModel()
        gameUser.level += 1
    }
    
    func getGameValue() -> GameValueModel {
        let gameUser = GameUserModel()
        let time = Double(gameUser.level * 20)
        return GameValueModel(level: gameUser.level, time: time)
    }
    
    func getCollection() {
        
    }
    
    func newCircleLevel(currentLevelValue: Int, currentTimeValue: Double) {
        
    }
}



