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
    func homeButtonPressed()
    func logoutButtonPressed()
    func deleteAccountButtonPressed()
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
    private var selectedKit: KitType = .planets
    private let authService: AuthServicable
    private let generalBackgroundAudioManager: AudioManagerable
    private let gameType: GameType
    private let gameService: GameServiceable
    private var gameModel: GameModel?
    
    // MARK: - Initializer
    
    init(
        sceneBuildManager: Buildable,
        alertManager: AlertManagerable,
        authService: AuthServicable,
        generalBackgroundAudioManager: AudioManagerable,
        gameType: GameType,
        gameService: GameServiceable
    ) {
        self.sceneBuildManager = sceneBuildManager
        self.alertManager = alertManager
        self.authService = authService
        self.generalBackgroundAudioManager = generalBackgroundAudioManager
        self.gameType = gameType
        self.gameService = gameService
    }
}

//MARK: - MainPresenterExtension

extension MainPresenter: MainPresenterProtocol {

    func viewDidLoad() {
        print("asdsadas")
        if gameType == .mission {
            viewController?.authUser()
        }
        
    }
    
    func viewWillAppear() {
        if gameType == .mission {
                
            gameModel = self.gameService.currentGameModel
            guard let levelLabelValue = gameModel?.level else {
                return
            }
            guard let timerLabelValue = gameModel?.time else {
                return
            }
            
            
            let timerLavelValueText = self.transformationTimerLabelText(timeValue: timerLabelValue)
            self.viewController?.updateLevelLabel(value: String(levelLabelValue))
            self.viewController?.updateTimeLabel(value: timerLavelValueText)
            self.viewController?.updateCollectionView(viewModel: self.fetchCurrentKitCell())
                
            
        } else {
            gameModel = GameModel(level: 1)
            viewController?.updateCollectionView(viewModel: fetchCurrentKitCell())
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
    
    func homeButtonPressed() {
        viewController?.expand()
    }

    func logoutButtonPressed() {
        if gameType == .mission {
            viewController?.present(
                sceneBuildManager.buildCustomPopUpScreen(
                    PopUpType: .logout,
                    delegate: self
                ),
                animated: true
            )
        } else {
            let rootViewController = UINavigationController.init(rootViewController: self.sceneBuildManager.buildMenuScreen())
            UIApplication.shared.windows.first?.rootViewController = rootViewController
        }
    }
    
    func deleteAccountButtonPressed() {
        viewController?.present(
            sceneBuildManager.buildCustomPopUpScreen(
                PopUpType: .deleteAccount,
                delegate: self
            ),
            animated: true
        )
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
            selectedKit = KitType(rawValue: value) ?? KitType.planets
            viewController?.scrollCollectionView(item: selectedKit.rawValue)
        }
    }
    
    func indicatorRightButtonPressed() {
        let value = selectedKit.rawValue + 1
        if value <= 3 {
            selectedKit = KitType(rawValue: value) ?? KitType.planets
            viewController?.scrollCollectionView(item: selectedKit.rawValue)
        }
    }
    
    func didScrollKitCollection(at indexPath: IndexPath) {
        selectedKit = KitType(rawValue: indexPath.item) ?? KitType.planets
        
        guard let currentLevel = gameModel?.level else {
            return
        }
        
        if indexPath.item == 0 {
            viewController?.lockIndicatorLeftButton()
            gameType == .mission
            ? viewController?.activeStartGameButton()
            : viewController?.activeDemoGameButton()
        } else {
            viewController?.activeIndicatorLeftButton()
        }
        
        if indexPath.item == 1 {
            currentLevel <= 10
            ? viewController?.lockStartGameButton()
            : viewController?.activeStartGameButton()
        }
        
        if indexPath.item == 2 {
            currentLevel <= 20
            ? viewController?.lockStartGameButton()
            : viewController?.activeStartGameButton()
        }
        
        if indexPath.item == 3 {
            viewController?.lockIndicatorRightButton()
            currentLevel <= 30
            ? viewController?.lockStartGameButton()
            : viewController?.activeStartGameButton()
        } else {
            viewController?.activeIndicatorRightButton()
        }
        
    }
}

private extension MainPresenter {
    
    private func fetchCurrentKitCell() -> [KitCellViewModel] {
        guard let gameModel = self.gameModel else {
            return []
        }
        let result = gameModel.kits.map {
            KitCellViewModel(image: $0.type.imageName, isLocked: $0.isLocked)
        }
        return result
    }
}

extension MainPresenter: CustomPopUpDelegate {
    func logout() {
        self.authService.logout { result in
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
    
    func deleteAccount() {
        self.authService.deleteUser { result in
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
