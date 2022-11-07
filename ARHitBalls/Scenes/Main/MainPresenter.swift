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
    func kitButtonsPressed(tag: Int)
}

// MARK: - MainPresenter

final class MainPresenter {
    weak var viewController: MainViewProtocol?
    
    // MARK: - PrivateProperties
    
    private let sceneBuildManager: Buildable
    private let alertManager: AlertManagerable
    private var selectedKit: KitEnum = .planets
    private let userService: UserServiceable
    private let generalBackgroundAudioManager: AudioManagerable
    private let gameType: GameType
    
    // MARK: - Initializer
    
    init(
        sceneBuildManager: Buildable,
        alertManager: AlertManagerable,
        userService: UserServiceable,
        generalBackgroundAudioManager: AudioManagerable,
        gameType: GameType
    ) {
        self.sceneBuildManager = sceneBuildManager
        self.alertManager = alertManager
        self.userService = userService
        self.generalBackgroundAudioManager = generalBackgroundAudioManager
        self.gameType = gameType
    }
}

//MARK: - MainPresenterExtension

extension MainPresenter: MainPresenterProtocol {
    func settingsButtonPressed() {
        let settingsViewController = sceneBuildManager.buildSettingsScreen(
            settingType: .mainSetting,
            selectedKit: selectedKit
        )
        viewController?.navigationController?.pushViewController(
            settingsViewController,
            animated: true
        )
    }
    
    func startQuickGameButtonPressed() {
        let settingViewController = sceneBuildManager.buildSettingsScreen(
            settingType: .quickGameSetting,
            selectedKit: selectedKit
        )
        viewController?.navigationController?.pushViewController(
            settingViewController,
            animated: true
        )
    }
    
    func logoutButtonPressed() {
        guard let viewController = viewController.self else {
            return
        }
        
        alertManager.showAlert(
            fromViewController: viewController,
            title: "Внимание",
            message: "Вы хотите выйти?",
            firstButtonTitle: "Отменить",
            firstActionBlock: {},
            secondTitleButton: "Выйти") {
                self.userService.logoutUser()
                let rootViewController = UINavigationController.init(rootViewController: self.sceneBuildManager.buildMenuScreen())
                UIApplication.shared.windows.first?.rootViewController = rootViewController
            }
    }
    
    func missionStartGameButtonPressed() {
        if gameType == .mission {
            let timerValue: Double = 20
            let currentLevelValue = 1
            
            let gameViewController = sceneBuildManager.buildGameScreen(
                timerValue: timerValue,
                levelValue: currentLevelValue,
                selectedKit: selectedKit,
                gameType: .mission
            )
            
            viewController?.navigationController?.pushViewController(
                gameViewController,
                animated: true
            )
            generalBackgroundAudioManager.pause()
        }
    }
    
    func kitButtonsPressed(tag: Int) {
        if tag == 0 {
            selectedKit = .planets
        } else if tag == 1 {
            selectedKit = .fruits
        } else if tag == 2 {
            selectedKit = .billiardBalls
        } else {
            selectedKit = .sportBalls
        }
    }
}
