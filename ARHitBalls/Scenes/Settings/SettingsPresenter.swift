//
//  SettingsPresenter.swift
//  ARHitBalls
//
//  Created by Swift Learning on 15.08.2022.
//

import UIKit

// MARK: - SettingsPresenterProtocol

protocol SettingsPresenterProtocol: AnyObject {
     func vibrationSwitcherChange()
     func soundEffectsSwitcherChenge()
     func musicSwitcherChange()
     func quitSettingsButtonPressed()
}

// MARK: - SettingsPresenter

final class SettingsPresenter {
    weak var viewController: SettingsViewController?
    
    // MARK: - PrivateProperties
    
    private let sceneBuildManager: Buildable
    
    // MARK: - Initializer
    
    init(sceneBuildManager: Buildable) {
        self.sceneBuildManager = sceneBuildManager
    }
}

//MARK: - SettingsPresenterExtension

extension SettingsPresenter: SettingsPresenterProtocol {
    func vibrationSwitcherChange() {}
    
    func soundEffectsSwitcherChenge() {}
    
    func musicSwitcherChange() {}
    
    func quitSettingsButtonPressed() {
        let rootViewController = sceneBuildManager.buildMainScreen()
        UIApplication.shared.windows.first?.rootViewController = rootViewController
    }
}
