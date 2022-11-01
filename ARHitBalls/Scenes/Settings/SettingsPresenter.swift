//
//  SettingsPresenter.swift
//  ARHitBalls
//
//  Created by Swift Learning on 15.08.2022.
//

// MARK: - SettingsPresenterProtocol

protocol SettingsPresenterProtocol: AnyObject, TimerProtocol {
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
    private let generalBackgroundAudioManager: AudioManagerable
    private let settingType: SettingType
    private let selectedKit: KitEnum
    private var timerValue: Double = 10
    private var currentLevelValue: Int = 1
    
    
    // MARK: - Initializer
    
    init(
        sceneBuildManager: Buildable,
        defaultsStorage: DefaultsManagerable,
        settingType: SettingType,
        selectedKit: KitEnum,
        generalBackgroundAudioManager: AudioManagerable
    ) {
        self.sceneBuildManager = sceneBuildManager
        self.defaultsStorage = defaultsStorage
        self.settingType = settingType
        self.selectedKit = selectedKit
        self.generalBackgroundAudioManager = generalBackgroundAudioManager
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
        let timerValue = defaultsStorage.fetchObject(
            type: Double.self,
            for: .timeValue
        ) ?? timerValue
        let correctTimeLabelText = transformationTimerLabelText(timeValue: timerValue)
        self.timerValue = timerValue
        currentLevelValue = Int(levelValue)
        
        viewController?.updateSwitchersValues(
            vibrationValue: vibrationSwitcherValue,
            soundValue: soundEffectsSwitcherValue,
            musicValue: musicSwitcherValue
        )
        
        viewController?.updateLevelValueLabel(
            levelValue: levelValue,
            levelText: String(currentLevelValue)
        )
        viewController?.updateTimeValueLabel(
            timeValue: timerValue,
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
        value ? generalBackgroundAudioManager.play() : generalBackgroundAudioManager.pause()
    }
    
    func quitSettingsButtonPressed() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
    func timeStepperPressed(timeValue: Double) {
        let correctTimeLabelText = transformationTimerLabelText(timeValue: timeValue)
        defaultsStorage.saveObject(
            timeValue,
            for: .timeValue
        )
        timerValue = timeValue
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
        currentLevelValue = Int(levelValue)
        viewController?.updateLevelValueLabel(
            levelValue: levelValue,
            levelText: String(Int(levelValue))
        )
    }
    
    func startQuickGameButtonPressed() {
        let gameViewController = sceneBuildManager.buildGameScreen(
            timerValue: timerValue,
            levelValue: currentLevelValue,
            selectedKit: selectedKit
        )
        
        viewController?.navigationController?.pushViewController(
            gameViewController,
            animated: true
        )
        generalBackgroundAudioManager.pause()
    }
}

private extension SettingsPresenter {}
