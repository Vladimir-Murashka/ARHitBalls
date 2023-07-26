//
//  GameService.swift
//  ARHitBalls
//
//  Created by Swift Learning on 15.08.2022.
//

import Foundation

protocol GameServiceable {
    func nextLevel() throws -> GameModel
    func getGameModel(completion: @escaping (GameModel?) -> Void)
}

final class GameService {
    
    // MARK: - PrivateProperties
    
    private var gameUserValue = GameUserModel()
    private let defaultsStorage: DefaultsManagerable
    private let firestore: FirebaseServiceProtocol
    private var currentGameModel: GameModel?
    
    // MARK: - Initializer
    
    init(defaultsStorage: DefaultsManagerable,
         firestore: FirebaseServiceProtocol) {
        self.defaultsStorage = defaultsStorage
        self.firestore = firestore
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
        
        let fbService: FirebaseServiceProtocol = FirebaseService()
        let model = LevelModel(userID: self.firestore.getUserID(), level: Level(level: nextGameModel.level))
        Repository(firebaseService: fbService).setCalculation(levelModel: model) { result in
            switch result {
            case .success(let success):
                print("MODEL SET:", success)
            case .failure(let failure):
                print(failure)
            }
        }
        
//        defaultsStorage.saveObject(
//            nextGameModel.level,
//            for: .missionGameLevelValue
//        )
        
        currentGameModel = nextGameModel
        
        return nextGameModel
    }
    
//    func getGameModel() throws -> GameModel {
//        guard let level = defaultsStorage.fetchObject(
//            type: Int.self,
//            for: .missionGameLevelValue
//        ) else {
//            let error = NSError(
//                domain: "error description",
//                code: -1
//            )
//            throw error
//        }
//        let gameModel = GameModel(level: level)
//        self.currentGameModel = gameModel
//
//        return gameModel
//    }
    
    func getGameModel(completion: @escaping (GameModel?) -> Void) {
        let fbService: FirebaseServiceProtocol = FirebaseService()
        Repository(firebaseService: fbService).getCalculation(userID: self.firestore.getUserID()) { result in
            switch result {
            case .success(let success):
                let gameModel = GameModel(level: success.level)
                self.currentGameModel = gameModel
                completion(gameModel)
            case .failure(let failure):
//                let error = NSError(
//                    domain: "error description",
//                    code: -1
//                )
                // Возможно тут будет ошибка, нужно тестить
                let gameModel = GameModel(level: 1)
                self.currentGameModel = gameModel
                completion(gameModel)
            }

        }
    }
}



