//
//  UserServise.swift
//  ARHitBalls
//
//  Created by Swift Learning on 15.08.2022.
//

protocol UserServiceable {
    func isUserAuth() -> Bool
    func registerUser()
    func logOut()
}

final class UserService {
    
    private let defaultsManager: DefaultsManagerable
    
    init(defaultsManager: DefaultsManagerable) {
        self.defaultsManager = defaultsManager
    }
}

extension UserService: UserServiceable {
    func isUserAuth() -> Bool {
        defaultsManager.fetchObject(type: Bool.self, for: .isUserAuth) ?? false
    }
    
    func registerUser() {
        defaultsManager.saveObject(true, for: .isUserAuth)
    }
    
    func logOut() {
        defaultsManager.deleteObject(for: .isUserAuth)
    }
}
