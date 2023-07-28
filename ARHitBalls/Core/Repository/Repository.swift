//
//  FirebaseRepository.swift
//  ARHitBalls
//
//  Created by Максим Косников on 23.07.2023.
//

import Foundation

protocol RepositoryProtocol {
    func setCalculation(levelModel: LevelModel,
                        completion: @escaping (Result<Bool, Error>) -> Void)
    func getCalculation(userID: String,
                        completion: @escaping (Result<Level, Error>) -> Void)
    func getAllCalculations(userID: String,
                            completion: @escaping (Result<[Level]?, Error>) -> Void)
    func deleteCalculation(userID: String,
                           completion: @escaping (Result<String, Error>) -> Void)
}

class Repository: RepositoryProtocol {
    var levelModel: Level?
    let firebaseService: FirebaseServiceProtocol
    
    init(levelModel: Level? = nil,
         firebaseService: FirebaseServiceProtocol) {
        self.levelModel = levelModel
        self.firebaseService = firebaseService
    }
    
    func setCalculation(levelModel: LevelModel,
                        completion: @escaping (Result<Bool, Error>) -> Void) {
        
        firebaseService.setCalculation(userID: levelModel.userID,
                                       levelModel: levelModel.level, completion: { result in
            switch result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    func getCalculation(userID: String,
                        completion: @escaping (Result<Level, Error>) -> Void) {
        firebaseService.getCalculation(userID: userID) { result in
            switch result {
            case .success(let calc):
                completion(.success(calc))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getAllCalculations(userID: String,
                            completion: @escaping (Result<[Level]?, Error>) -> Void) {
        firebaseService.getAllCalculations(userID: userID) { result in
            switch result {
            case .success(let calc):
                guard let calc = calc else {
                    completion(.success(nil))
                    return
                }
                var allCalcModel: [Level] = []
                for element in calc {
                    allCalcModel.append(self.oneCalculation(from: element.data()))
                }
                completion(.success(allCalcModel))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func oneCalculation(from calcDict: [String: Any]) -> Level {
        let decoder = JSONDecoder()
        
        var model = Level(level: 1)
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: calcDict,
                                                      options: JSONSerialization.WritingOptions.prettyPrinted)
            model = try decoder.decode(Level.self,
                                       from: jsonData)
        } catch {
            print("Error", error)
        }
        return model
    }
    
    func deleteCalculation(userID: String,
                           completion: @escaping (Result<String, Error>) -> Void) {
        
    }
}
