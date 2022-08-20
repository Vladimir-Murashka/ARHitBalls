//
//  RegistrationPresenter.swift
//  ARHitBalls
//
//  Created by Swift Learning on 16.08.2022.
//

import UIKit

// MARK: -  RegistrationPresenterProtocol

protocol  RegistrationPresenterProtocol: AnyObject {
    func registrationButtonPressed()
    func quitButtonPressed()
}

// MARK: -  RegistrationPresenter

final class  RegistrationPresenter {
    weak var viewController: RegistrationViewController?
    
    // MARK: - PrivateProperties
    
    private let sceneBuildManager: Buildable
    
    // MARK: - Initializer
    
    init(sceneBuildManager: Buildable) {
        self.sceneBuildManager = sceneBuildManager
    }
}

//MARK: -  RegistrationPresenterExtension

extension  RegistrationPresenter: RegistrationPresenterProtocol {
    func registrationButtonPressed() {
        let rootViewController = sceneBuildManager.buildMainScreen()
        UIApplication.shared.windows.first?.rootViewController = rootViewController
    }
    
    func quitButtonPressed() {
        let rootViewController = sceneBuildManager.buildMenuScreen()
        UIApplication.shared.windows.first?.rootViewController = rootViewController
    }
}
