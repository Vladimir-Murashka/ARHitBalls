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
        let settingsViewController = sceneBuildManager.buildSettingsScreen(settingType: .mainSetting)
        viewController?.navigationController?.pushViewController(settingsViewController, animated: true)
    }
    
    func startQuickGameButtonPressed() {
        let settingViewController = sceneBuildManager.buildSettingsScreen(settingType: .quickGameSetting)
        viewController?.navigationController?.pushViewController(settingViewController, animated: true)
    }
    
    func logoutButtonPressed() {
        viewController?.navigationController?.popToRootViewController(animated: true)
    }
    
    func missionStartGameButtonPressed() {
        print(#function)
    }
}
