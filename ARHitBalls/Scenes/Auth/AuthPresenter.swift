//
//  AuthPresenter.swift
//  ARHitBalls
//
//  Created by Swift Learning on 15.08.2022.
//

import UIKit

// MARK: - AuthPresenterProtocol

protocol AuthPresenterProtocol: AnyObject {
    func authButtonPressed()
    func quitButtonPressed()
}

// MARK: - AuthPresenter

final class AuthPresenter {
    weak var viewController: AuthViewController?
    
    // MARK: - PrivateProperties
    
    private let sceneBuildManager: Buildable
    
    // MARK: - Initializer
    
    init(sceneBuildManager: Buildable) {
        self.sceneBuildManager = sceneBuildManager
    }
}

//MARK: - AuthPresenterExtension

extension AuthPresenter: AuthPresenterProtocol {
    func authButtonPressed() {
        let rootViewController = sceneBuildManager.buildMainScreen()
        UIApplication.shared.windows.first?.rootViewController = rootViewController
    }
    
    func quitButtonPressed() {
        let rootViewController = sceneBuildManager.buildMenuScreen()
        UIApplication.shared.windows.first?.rootViewController = rootViewController
    }
}
