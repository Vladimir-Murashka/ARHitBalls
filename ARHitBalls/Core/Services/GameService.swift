//
//  GameService.swift
//  ARHitBalls
//
//  Created by Swift Learning on 15.08.2022.
//

protocol GameServiceable {
    func nextLevel(levelValue: Int, timeValue: Double)
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
    func nextLevel(levelValue: Int, timeValue: Double) {
        levelValue < maxLevelValue ? (gameLevelValue += 1) : (gameLevelValue = 1)
        timeValue < maxTimeValue ? (gameTimeValue += 20) : (gameTimeValue = 20)
    }
    
    func getCollection() {
        
    }
    
    func newCircleLevel(currentLevelValue: Int, currentTimeValue: Double) {
        
    }
}



