//
//  RegistrationPresenter.swift
//  ARHitBalls
//
//  Created by Swift Learning on 16.08.2022.
//

import UIKit

// MARK: -  RegistrationPresenterProtocol

protocol  IdentifirePresenterProtocol: AnyObject {
    func continueButtonPressed()
    func quitButtonPressed()
    func viewDidLoad()
}

// MARK: -  RegistrationPresenter

final class  IdentifirePresenter {
    weak var viewController: IdentifireViewController?
    
    // MARK: - PrivateProperties
    
    private let sceneBuildManager: Buildable
    private let type: AuthType
    
    // MARK: - Initializer
    
    init(
        sceneBuildManager: Buildable,
        type: AuthType
    ) {
        self.sceneBuildManager = sceneBuildManager
        self.type = type
    }
}

//MARK: -  RegistrationPresenterExtension

extension  IdentifirePresenter: IdentifirePresenterProtocol {
    func viewDidLoad() {
        type == .auth
        ? viewController?.setupAuth()
        : viewController?.setupRegister()
    }
    func continueButtonPressed() {
        let rootViewController = sceneBuildManager.buildMainScreen()
        UIApplication.shared.windows.first?.rootViewController = rootViewController
    }
    
    func quitButtonPressed() {
        let rootViewController = sceneBuildManager.buildMenuScreen()
        UIApplication.shared.windows.first?.rootViewController = rootViewController
    }
}
