//
//  SettingsPresenter.swift
//  ARHitBalls
//
//  Created by Swift Learning on 15.08.2022.
//

import UIKit

// MARK: - SettingsPresenterProtocol

protocol SettingsPresenterProtocol: AnyObject {
    func viewDidLoad()
    func vibrationSwitcherChange(value: Bool)
    func soundEffectsSwitcherChange(value: Bool)
    func musicSwitcherChange(value: Bool)
    func quitSettingsButtonPressed()
}

// MARK: - SettingsPresenter

final class SettingsPresenter {
    weak var viewController: SettingsViewProtocol?
    
    // MARK: - PrivateProperties
    
    private let sceneBuildManager: Buildable
    private let defaultsStorage: DefaultsManagerable
    
    // MARK: - Initializer
    
    init(
        sceneBuildManager: Buildable,
        defaultsStorage: DefaultsManagerable
    ) {
        self.sceneBuildManager = sceneBuildManager
        self.defaultsStorage = defaultsStorage
    }
}

//MARK: - SettingsPresenterExtension

extension SettingsPresenter: SettingsPresenterProtocol {
    func viewDidLoad() {
        let vibrationSwitcherValue = defaultsStorage.fetchObject(type: Bool.self, for: .isVibrationOn) ?? true
        let soundEffectsSwitcherValue = defaultsStorage.fetchObject(type: Bool.self, for: .isSoundOn) ?? true
        let musicSwitcherValue = defaultsStorage.fetchObject(type: Bool.self, for: .isMusicOn) ?? true
        
        viewController?.updateSwitchersValues(
            vibrationValue: vibrationSwitcherValue,
            soundValue: soundEffectsSwitcherValue,
            musicValue: musicSwitcherValue
        )
    }
    func vibrationSwitcherChange(value: Bool) {
        defaultsStorage.saveObject(value, for: .isVibrationOn)
    }

    func soundEffectsSwitcherChange(value: Bool) {
        defaultsStorage.saveObject(value, for: .isSoundOn)
    }
    
    func musicSwitcherChange(value: Bool) {
        defaultsStorage.saveObject(value, for: .isMusicOn)
    }
    
    func quitSettingsButtonPressed() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
