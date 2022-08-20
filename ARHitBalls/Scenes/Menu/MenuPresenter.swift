//
//  MenuPresenter.swift
//  ARHitBalls
//
//  Created by Swift Learning on 15.08.2022.
//

import UIKit

// MARK: - MenuPresenterProtocol

protocol MenuPresenterProtocol: AnyObject {
    func startButtonWithoutRegisterPressed()
    func authButtonPressed()
    func registerButtonPressed()
}

// MARK: - MenuPresenter

final class MenuPresenter {
    weak var viewController: MenuViewController?
    
    // MARK: - PrivateProperties
    
    private let sceneBuildManager: Buildable
    
    // MARK: - Initializer
    
    init(sceneBuildManager: Buildable) {
        self.sceneBuildManager = sceneBuildManager
    }
}

//MARK: - MenuPresenterExtension

extension MenuPresenter: MenuPresenterProtocol {
    func startButtonWithoutRegisterPressed() {
        let rootViewController = sceneBuildManager.buildMainScreen()
        viewController?.navigationController?.pushViewController(rootViewController, animated: true)
    }
    
    func authButtonPressed() {
        let rootViewController = sceneBuildManager.buildAuthScreen()
        UIApplication.shared.windows.first?.rootViewController = rootViewController
    }
    
    func registerButtonPressed() {
        let rootViewController = sceneBuildManager.buildRegistrationScreen()
        UIApplication.shared.windows.first?.rootViewController = rootViewController
    }
}

