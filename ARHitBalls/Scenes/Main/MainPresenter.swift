//
//  MainPresenter.swift
//  ARHitBalls
//
//  Created by Swift Learning on 15.08.2022.
//

import UIKit

// MARK: - MainPresenterProtocol

protocol MainPresenterProtocol: AnyObject, TimerProtocol {
    func viewDidLoad()
    func viewWillAppear()
    func settingsButtonPressed()
    func startQuickGameButtonPressed()
    func logoutButtonPressed()
    func missionStartGameButtonPressed()
    func indicatorLeftButtonPressed()
    func indicatorRightButtonPressed()
    func didScrollKitCollection(at indexPath: IndexPath)
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
    private var gameModel: GameModel?
    
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
        if gameType == .mission {
            viewController?.authUser()
        }
    }
    
    func viewWillAppear() {
        if gameType == .mission {
            do {
                gameModel = try gameService.getGameModel()
            } catch {
                // обработать ошибку
            }
            guard let levelLabelValue = gameModel?.level else {
                return
            }
            
            guard let timerLabelValue = gameModel?.time else {
                return
            }
            let timerLavelValueText = transformationTimerLabelText(timeValue: timerLabelValue)
            
            viewController?.updateLevelLabel(value: String(levelLabelValue))
            viewController?.updateTimeLabel(value: timerLavelValueText)
        }
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
        if gameType == .mission {
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
        } else {
            let rootViewController = UINavigationController.init(rootViewController: self.sceneBuildManager.buildMenuScreen())
            UIApplication.shared.windows.first?.rootViewController = rootViewController
        }
    }
    
    func missionStartGameButtonPressed() {
        if gameType == .mission {
            guard let currentLevelValue = gameModel?.level else {
                return
            }
            
            guard let currentTimeValue = gameModel?.time else {
                return
            }
            
            let gameViewController = sceneBuildManager.buildGameScreen(
                timerValue: currentTimeValue,
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
    
    func indicatorLeftButtonPressed() {
        let value = selectedKit.rawValue - 1
        if value >= 0 {
            selectedKit = KitEnum(rawValue: value) ?? KitEnum.planets
            viewController?.scrollCollectionView(item: selectedKit.rawValue)
        }
    }
    
    func indicatorRightButtonPressed() {
        let value = selectedKit.rawValue + 1
        if value <= 3 {
            selectedKit = KitEnum(rawValue: value) ?? KitEnum.planets
            viewController?.scrollCollectionView(item: selectedKit.rawValue)
        }
    }
    
    func didScrollKitCollection(at indexPath: IndexPath) {
        selectedKit = KitEnum(rawValue: indexPath.row) ?? KitEnum.planets
    }
}
