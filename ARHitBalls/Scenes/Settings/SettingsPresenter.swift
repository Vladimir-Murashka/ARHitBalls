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
    func timeStepperPressed()
    func levelStepperPressed()
    func startQuickGameButtonPressed()
}

// MARK: - SettingsPresenter

final class SettingsPresenter {
    weak var viewController: SettingsViewProtocol?
    
    // MARK: - PrivateProperties
    
    private let sceneBuildManager: Buildable
    private let defaultsStorage: DefaultsManagerable
    private let settingType: SettingType
    
    // MARK: - Initializer
    
    init(
        sceneBuildManager: Buildable,
        defaultsStorage: DefaultsManagerable,
        settingType: SettingType
    ) {
        self.sceneBuildManager = sceneBuildManager
        self.defaultsStorage = defaultsStorage
        self.settingType = settingType
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
        
        settingType == .mainSetting
        ? viewController?.setupMainSetting()
        : viewController?.setupQuickGameSetting()
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
    
    func timeStepperPressed() {}
    
    func levelStepperPressed() {}
    
    func startQuickGameButtonPressed() {
        let gameViewController = sceneBuildManager.buildGameScreen()
        viewController?.navigationController?.pushViewController(gameViewController, animated: true)
    }
}
