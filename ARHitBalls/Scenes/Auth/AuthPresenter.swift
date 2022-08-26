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
    weak var viewController: AuthViewProtocol?
    
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
        let mainViewController = sceneBuildManager.buildMainScreen()
        viewController?.navigationController?.pushViewController(mainViewController, animated: true)
    }
    
    func quitButtonPressed() {
        viewController?.navigationController?.popViewController(animated: false)
    }
}
