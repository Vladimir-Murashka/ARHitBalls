//
//  FirebaseService.swift
//  ARHitBalls
//
//  Created by Swift Learning on 05.11.2022.
//

import FirebaseAuth
import FirebaseCore
import Foundation

protocol FirebaseServicable {
    func singIn(
        email: String,
        password: String,
        completion: @escaping (Result<UserModel, Error>) -> Void
    )
    func createUser(
        email: String,
        password: String,
        completion: @escaping (Result<UserModel, Error>) -> Void
    )
    
    func logout() throws
}

final class FirebaseService {
    
}

extension FirebaseService: FirebaseServicable {
    func singIn(
        email: String,
        password: String,
        completion: @escaping (Result<UserModel, Error>) -> Void
    ) {
        Auth.auth().signIn(
            withEmail: email,
            password: password
        ) { user, error in
            if let error = error {
                completion(.failure(error))
            }
            
            if let _ = user {
                let userModel = UserModel()
                completion(.success(userModel))
            }
        }
    }
    
    func createUser(
        email: String,
        password: String,
        completion: @escaping (Result<UserModel, Error>) -> Void
    ) {
        Auth.auth().createUser(
            withEmail: email,
            password: password
        ) { user, error in
            if let error = error {
                completion(.failure(error))
            }
            
            if let _ = user {
                let userModel = UserModel()
                completion(.success(userModel))
            }
        }
    }
    
    func logout() throws {
        try Auth.auth().signOut()
    }
}



