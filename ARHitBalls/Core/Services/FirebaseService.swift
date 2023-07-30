//
//  FirebaseService.swift
//  ARHitBalls
//
//  Created by Natalia Shevaldina on 20.05.2023.
//

import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift

protocol FirebaseServiceProtocol {
    func setDocument(userID: String,
                        levelModel: Level,
                        completion: @escaping (Result<Bool, Error>) -> Void)
    
    func getDocument(userID: String,
                        completion: @escaping (Result<Level, Error>) -> Void)
    
    func getAllDocuments(userID: String,
                            completion: @escaping (Result<[QueryDocumentSnapshot]?, Error>) -> Void)
    
    func deleteDocument(userID: String,
                           completion: @escaping (Result<String, Error>) -> Void)
    func addUserID(userID: String)
    func getUserID() -> String
}

final class FirebaseService {
    var uid: String?
    static let shared = FirebaseService()
    func configureFB() -> Firestore {
        var database: Firestore
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        database = Firestore.firestore()
        return database
    }
}

extension FirebaseService: FirebaseServiceProtocol {
    func getUserID() -> String {
        print(self.uid)
        guard let uid = self.uid else { return "" }
        return uid
    }
    
    func addUserID(userID: String) {
        self.uid = userID
        print(self.uid)
    }
    
    func setDocument(userID: String,
                        levelModel: Level,
                        completion: @escaping (Result<Bool, Error>) -> Void) {
        let db = configureFB()
        let calcRef = db.collection(userID).document("level")
//        calcRef.setData(calcModel) { error in
//            if let error = error {
//                print("FirebaseService setDocument: Error writing document: \(error)")
//                completion(.failure(error))
//            } else {
//                print("FirebaseService setDocument: Document successfully written!")
//                completion(.success(""))
//            }
//        }
        do {
            try calcRef.setData(from: levelModel) { error in
                if let error = error {
                    print("FirebaseService setDocument: Error writing document: \(error)")
                    completion(.failure(error))
                } else {
                    print("FirebaseService setDocument: Document successfully written!")
                    completion(.success(true))
                }
            }
        } catch let error {
            print("FirebaseService setDocument: Error writing to Firestore: \(error)")
            completion(.failure(error))
        }
    }
    
    func getDocument(userID: String,
                        completion: @escaping (Result<Level, Error>) -> Void) {
        let db = configureFB()
        let calcRef = db.collection(userID).document("level")
//        calcRef.getDocument { (document, error) in
//            if let document = document, document.exists {
//                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
//                print("Document data: \(dataDescription)")
//            } else {
//                print("Document does not exist")
//            }
//        }
        calcRef.getDocument(as: Level.self) { result in
            switch result {
            case .success(let calc):
                print("GameModel: \(calc)")
                completion(.success(calc))
            case .failure(let error):
                print("Error decoding GameModel: \(error)")
                completion(.failure(error))
            }
        }
    }
    
    func getAllDocuments(userID: String,
                           completion: @escaping (Result<[QueryDocumentSnapshot]?, Error>) -> Void) {
        let db = configureFB()
        let calcRef = db.collection(userID)
        calcRef.getDocuments() { (querySnapshot, error) in
            guard let querySnapshot = querySnapshot else {
                print("ERROR getAllDocuments querySnapshot")
                completion(.success(nil))
                return
            }
            if let error = error {
                print("Error getting documents: \(error)")
                completion(.failure(error))
            } else {
                completion(.success(querySnapshot.documents))
            }
        }
    }
    
    func deleteDocument(userID: String,
                           completion: @escaping (Result<String, Error>) -> Void) {
        let db = configureFB()
        let calcRef = db.collection(userID).document("level")
        calcRef.delete() { error in
            if let error = error {
                print("Error removing document: \(error)")
                completion(.failure(error))
            } else {
                print("Document successfully removed!")
                completion(.success(""))
            }
        }
    }
}
