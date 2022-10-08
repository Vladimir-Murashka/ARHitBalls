//
//  MainPresenter.swift
//  ARHitBalls
//
//  Created by Swift Learning on 15.08.2022.
//

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
    
    // MARK: - Initializer
    
    init(
        sceneBuildManager: Buildable,
        alertManager: AlertManagerable
    ) {
        self.sceneBuildManager = sceneBuildManager
        self.alertManager = alertManager
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
                self.viewController?.navigationController?.popToRootViewController(animated: true)
            }
    }
    
    func missionStartGameButtonPressed() {
        print(#function)
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
