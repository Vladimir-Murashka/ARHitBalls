//
//  SettingsPresenter.swift
//  ARHitBalls
//
//  Created by Swift Learning on 15.08.2022.
//

import UIKit

// MARK: - SettingsPresenterProtocol

protocol SettingsPresenterProtocol: AnyObject {
    func vibrationSwitcherChange(_ sender: UISwitch)
    func soundEffectsSwitcherChange(_ sender: UISwitch)
    func musicSwitcherChange(_ sender: UISwitch)
    func quitSettingsButtonPressed()
    func fetchValueVibrationSwitcher() -> Bool
    func fetchValueSoundEffectsSwitcher() -> Bool
    func fetchValueMusicSwitcher() -> Bool
}

// MARK: - SettingsPresenter

final class SettingsPresenter {
    weak var viewController: SettingsViewController?
    let defaultsStorage: DefaultsManagerable = DefaultsManager()
    
    // MARK: - PrivateProperties
    
    private let sceneBuildManager: Buildable
    
    // MARK: - Initializer
    
    init(sceneBuildManager: Buildable) {
        self.sceneBuildManager = sceneBuildManager
    }
}

//MARK: - SettingsPresenterExtension

extension SettingsPresenter: SettingsPresenterProtocol {
    func vibrationSwitcherChange(_ sender: UISwitch) {
        defaultsStorage.saveObject(sender.isOn, for: .isVibrationOn)
    }

    func soundEffectsSwitcherChange(_ sender: UISwitch) {
        defaultsStorage.saveObject(sender.isOn, for: .isSoundEffect)
    }
    
    func musicSwitcherChange(_ sender: UISwitch) {
        defaultsStorage.saveObject(sender.isOn, for: .isMusicOn)
    }
    
    func fetchValueVibrationSwitcher() -> Bool {
        let valueVibrationSwitcher = defaultsStorage.fetchObject(type: Bool.self, for: .isVibrationOn) ?? true
    
        return valueVibrationSwitcher
    }
    
    func fetchValueSoundEffectsSwitcher() -> Bool {
        let valueSoundEffectsSwitcher = defaultsStorage.fetchObject(type: Bool.self, for: .isSoundEffect) ?? true
        
        return valueSoundEffectsSwitcher
    }
    
    func fetchValueMusicSwitcher() -> Bool {
        let valueMusicSwitcher = defaultsStorage.fetchObject(type: Bool.self, for: .isMusicOn) ?? true
        
        return valueMusicSwitcher
    }
    
    func quitSettingsButtonPressed() {
        let rootViewController = sceneBuildManager.buildMainScreen()
        UIApplication.shared.windows.first?.rootViewController = rootViewController
    }

    
}
