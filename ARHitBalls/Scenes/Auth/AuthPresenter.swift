//
//  AuthPresenter.swift
//  ARHitBalls
//
//  Created by Swift Learning on 15.08.2022.
//

// MARK: - AuthPresenterProtocol
protocol AuthPresenterProtocol: AnyObject {
    
}

// MARK: - AuthPresenter
final class AuthPresenter {
    
    weak var viewController: AuthViewController?
    
    private let sceneBuildManager: Buildable
    
    init(sceneBuildManager: Buildable) {
        self.sceneBuildManager = sceneBuildManager
    }
}

//MARK: - MenuPresenterExtension
extension AuthPresenter: AuthPresenterProtocol {
    
}
