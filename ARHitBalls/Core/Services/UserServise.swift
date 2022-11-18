//
//  UserServise.swift
//  ARHitBalls
//
//  Created by Swift Learning on 15.08.2022.
//

protocol UserServiceable {
    func isUserAuth() -> Bool
    func registerUser(
        email: String,
        password: String,
        completion: @escaping (Result<Void, Error>) -> Void
    )
    func authUser(
        email: String,
        password: String,
        completion: @escaping (Result<Void, Error>) -> Void
    )
    func logoutUser(completion: @escaping (Result<Void, Error>) -> Void)
}

final class UserService {
    
    private let defaultsManager: DefaultsManagerable
    private let firebaseService: FirebaseServicable
    
    init(
        defaultsManager: DefaultsManagerable,
        firebaseService: FirebaseServicable
    ) {
        self.defaultsManager = defaultsManager
        self.firebaseService = firebaseService
    }
}

extension UserService: UserServiceable {
    func isUserAuth() -> Bool {
        defaultsManager.fetchObject(
            type: Bool.self,
            for: .isUserAuth
        ) ?? false
    }
    
    func registerUser(
        email: String,
        password: String,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        firebaseService.createUser(
            email: email,
            password: password
        ) { [weak self] result in
            switch result {
            case .success(_):
                self?.defaultsManager.saveObject(true, for: .isUserAuth)
                self?.defaultsManager.saveObject(1, for: .missionGameLevelValue)
                completion(.success(Void()))
                
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    func authUser(
        email: String,
        password: String,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        firebaseService.singIn(
            email: email,
            password: password
        ) { [weak self] result in
            switch result {
            case .success(_):
                self?.defaultsManager.saveObject(true, for: .isUserAuth)
                completion(.success(Void()))
                
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    func logoutUser(completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            try firebaseService.logout()
            defaultsManager.saveObject(false, for: .isUserAuth)
            completion(.success(Void()))
        } catch {
            completion(.failure(error))
        }
    }
}
