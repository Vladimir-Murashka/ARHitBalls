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
    
    func logOut()
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
            
            if let user = user {
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
            
            if let user = user {
                let userModel = UserModel()
                completion(.success(userModel))
            }
        }
    }
    
    func logOut() {
        do {
               try Auth.auth().signOut()
           }
        catch {}
    }
}



