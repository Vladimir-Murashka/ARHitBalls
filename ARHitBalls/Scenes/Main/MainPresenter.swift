//
//  MainPresenter.swift
//  ARHitBalls
//
//  Created by Swift Learning on 15.08.2022.
//

import UIKit

// MARK: - MainPresenterProtocol

protocol MainPresenterProtocol: AnyObject {
    func settingsButtonPressed()
    func startQuickGameButtonPressed()
    func logoutButtonPressed()
    func missionStartGameButtonPressed()
}

// MARK: - MainPresenter

final class MainPresenter {
    weak var viewController: MainViewProtocol?
    
    // MARK: - PrivateProperties
    
    private let sceneBuildManager: Buildable
    
    // MARK: - Initializer
    
    init(sceneBuildManager: Buildable) {
        self.sceneBuildManager = sceneBuildManager
    }
}

//MARK: - MainPresenterExtension

extension MainPresenter: MainPresenterProtocol {
    func settingsButtonPressed() {
        let rootViewController = sceneBuildManager.buildSettingsScreen()
        UIApplication.shared.windows.first?.rootViewController = rootViewController
    }
    
    func startQuickGameButtonPressed() {
        print(#function)
    }
    
    func logoutButtonPressed() {
        //let rootViewController = UINavigationController(rootViewController: sceneBuildManager.buildMenuScreen())
        //UIApplication.shared.windows.first?.rootViewController = rootViewController
        viewController?.navigationController?.popViewController(animated: true)
    }
    
    func missionStartGameButtonPressed() {
        print(#function)
    }
}
