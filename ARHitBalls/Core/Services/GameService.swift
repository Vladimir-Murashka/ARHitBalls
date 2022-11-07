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
    
    private let maxLevelValue: Int = 10
    private let maxTimeValue: Double = 200
    private var gameUserValue = GameUserModel()
    
}

extension GameService: GameServiceable {
    func nextLevel() {
        gameUserValue.levelValue += 1
    }
    
    func getGameValue() -> GameValueModel {
        let timerValue = Double(gameUserValue.levelValue * 20)
        return GameValueModel(levelValue: gameUserValue.levelValue, timeValue: timerValue)
    }
    
    func getCollection() {
        
    }
    
    func newCircleLevel(currentLevelValue: Int, currentTimeValue: Double) {
        
    }
}



