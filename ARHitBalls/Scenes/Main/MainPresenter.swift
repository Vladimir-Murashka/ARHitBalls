//
//  MainPresenter.swift
//  ARHitBalls
//
//  Created by Swift Learning on 15.08.2022.
//

import UIKit

// MARK: - MainPresenterProtocol

protocol MainPresenterProtocol: AnyObject {
    func viewDidLoad()
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
    private let gameService: GameServiceable
    
    // MARK: - Initializer
    
    init(
        sceneBuildManager: Buildable,
        alertManager: AlertManagerable,
        userService: UserServiceable,
        generalBackgroundAudioManager: AudioManagerable,
        gameType: GameType,
        gameService: GameServiceable
    ) {
        self.sceneBuildManager = sceneBuildManager
        self.alertManager = alertManager
        self.userService = userService
        self.generalBackgroundAudioManager = generalBackgroundAudioManager
        self.gameType = gameType
        self.gameService = gameService
    }
}

//MARK: - MainPresenterExtension

extension MainPresenter: MainPresenterProtocol {
    func viewDidLoad() {
       
    }
    
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
        alertManager.showAlert(
            fromViewController: viewController,
            title: "Внимание",
            message: "Вы хотите выйти?",
            firstButtonTitle: "Отменить",
            firstActionBlock: {},
            secondTitleButton: "Выйти") {
                self.userService.logoutUser { result in
                    switch result {
                    case .success(_):
                        let rootViewController = UINavigationController.init(rootViewController: self.sceneBuildManager.buildMenuScreen())
                        UIApplication.shared.windows.first?.rootViewController = rootViewController
                    case .failure(_):
                        self.alertManager.showAlert(
                            fromViewController: self.viewController,
                            title: "Ошибка",
                            message: "Проверьте соеденение с интернетом",
                            firstButtonTitle: "OK") {}
                    }
                }
            }
    }
    
    func missionStartGameButtonPressed() {
        let gameValue = gameService.getGameValue()
        if gameType == .mission {
            let timerValue = gameValue.timeValue
            let currentLevelValue = gameValue.levelValue
            
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
