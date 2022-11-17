//
//  GameService.swift
//  ARHitBalls
//
//  Created by Swift Learning on 15.08.2022.
//

protocol GameServiceable {
    func nextLevel()
    func getGameValue() -> GameValueModel
}

final class GameService {
    
    // MARK: - PrivateProperties
    
    private var gameUserValue = GameUserModel()
    private let defaultsStorage: DefaultsManagerable
    
    // MARK: - Initializer
    
    init(defaultsStorage: DefaultsManagerable) {
        self.defaultsStorage = defaultsStorage
    }
}

extension GameService: GameServiceable {
    func nextLevel() {
        gameUserValue = defaultsStorage.fetchObject(type: GameUserModel.self, for: .gameUserValue) ?? GameUserModel(level: 1)
        gameUserValue = GameUserModel(level: 2)
        defaultsStorage.saveObject(gameUserValue, for: .gameUserValue)
    }
    
    func getGameValue() -> GameValueModel {
        gameUserValue = defaultsStorage.fetchObject(type: GameUserModel.self, for: .gameUserValue) ?? GameUserModel(level: 1)
        return GameValueModel(levelValue: gameUserValue.levelValue)
    }
}



