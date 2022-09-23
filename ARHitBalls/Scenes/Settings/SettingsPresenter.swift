//
//  SettingsPresenter.swift
//  ARHitBalls
//
//  Created by Swift Learning on 15.08.2022.
//

// MARK: - SettingsPresenterProtocol

protocol SettingsPresenterProtocol: AnyObject {
    func viewDidLoad()
    func vibrationSwitcherChange(value: Bool)
    func soundEffectsSwitcherChange(value: Bool)
    func musicSwitcherChange(value: Bool)
    func quitSettingsButtonPressed()
    func timeStepperPressed(timeValue: Double)
    func levelStepperPressed(levelValue: Double)
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
        let vibrationSwitcherValue = defaultsStorage.fetchObject(
            type: Bool.self,
            for: .isVibrationOn
        ) ?? true
        let soundEffectsSwitcherValue = defaultsStorage.fetchObject(
            type: Bool.self,
            for: .isSoundOn
        ) ?? true
        let musicSwitcherValue = defaultsStorage.fetchObject(
            type: Bool.self,
            for: .isMusicOn
        ) ?? true
        let levelValue = defaultsStorage.fetchObject(
            type: Double.self,
            for: .levelValue
        ) ?? 1
        let timeValue = defaultsStorage.fetchObject(
            type: Double.self,
            for: .timeValue
        ) ?? 10
        let correctTimeLabelText = transformationTimeLabelText(timeValue: timeValue)
        
        viewController?.updateSwitchersValues(
            vibrationValue: vibrationSwitcherValue,
            soundValue: soundEffectsSwitcherValue,
            musicValue: musicSwitcherValue
        )
        
        viewController?.updateLevelValueLabel(
            levelValue: levelValue,
            levelText: String(Int(levelValue))
        )
        viewController?.updateTimeValueLabel(
            timeValue: timeValue,
            timeText: correctTimeLabelText
        )
        
        settingType == .mainSetting
        ? viewController?.setupMainSetting()
        : viewController?.setupQuickGameSetting()
    }
    
    func vibrationSwitcherChange(value: Bool) {
        defaultsStorage.saveObject(
            value,
            for: .isVibrationOn
        )
    }

    func soundEffectsSwitcherChange(value: Bool) {
        defaultsStorage.saveObject(
            value,
            for: .isSoundOn
        )
    }
    
    func musicSwitcherChange(value: Bool) {
        defaultsStorage.saveObject(
            value,
            for: .isMusicOn
        )
    }
    
    func quitSettingsButtonPressed() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
    func timeStepperPressed(timeValue: Double) {
        let correctTimeLabelText = transformationTimeLabelText(timeValue: timeValue)
        defaultsStorage.saveObject(
            timeValue,
            for: .timeValue
        )
        viewController?.updateTimeValueLabel(
            timeValue: timeValue,
            timeText: correctTimeLabelText
        )
    }
    
    func levelStepperPressed(levelValue: Double) {
        defaultsStorage.saveObject(
            levelValue,
            for: .levelValue
        )
        viewController?.updateLevelValueLabel(
            levelValue: levelValue,
            levelText: String(Int(levelValue))
        )
    }
    
    func startQuickGameButtonPressed() {
        let gameViewController = sceneBuildManager.buildGameScreen()
        viewController?.navigationController?.pushViewController(
            gameViewController,
            animated: true
        )
    }
    
    func transformationTimeLabelText(timeValue: Double) -> String {
        let timeStepperValue = Int(timeValue)
        let seconds = timeStepperValue % 60
        let minutes = (timeStepperValue / 60) % 60
        let result = String(
            format: "%02d:%02d",
            minutes,
            seconds
        )
        return result
    }
}
