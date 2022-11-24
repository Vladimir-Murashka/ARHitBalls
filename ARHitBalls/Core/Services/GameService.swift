//
//  GameService.swift
//  ARHitBalls
//
//  Created by Swift Learning on 15.08.2022.
//

import Foundation

protocol GameServiceable {
    func nextLevel() throws -> GameModel
    func getGameModel() throws -> GameModel
}

final class GameService {
    
    // MARK: - PrivateProperties
    
    private var gameUserValue = GameUserModel()
    private let defaultsStorage: DefaultsManagerable
    
    private var currentGameModel: GameModel?
    
    // MARK: - Initializer
    
    init(defaultsStorage: DefaultsManagerable) {
        self.defaultsStorage = defaultsStorage
    }
}

extension GameService: GameServiceable {
    func nextLevel() throws -> GameModel {
        guard var nextGameModel = currentGameModel else {
            let error = NSError(
                domain: "error description",
                code: -1
            )
            throw error
        }
        
        nextGameModel.levelUP()
        
        defaultsStorage.saveObject(
            nextGameModel.level,
            for: .missionGameLevelValue
        )
        currentGameModel = nextGameModel
        
        return nextGameModel
    }
    
    func getGameModel() throws -> GameModel {
        guard let level = defaultsStorage.fetchObject(
            type: Int.self,
            for: .missionGameLevelValue
        ) else {
            let error = NSError(
                domain: "error description",
                code: -1
            )
            throw error
        }
        let gameModel = GameModel(level: level)
        self.currentGameModel = gameModel
                
        return gameModel
    }
}



