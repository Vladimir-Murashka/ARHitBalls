//
//  MainPresenter.swift
//  ARHitBalls
//
//  Created by Swift Learning on 15.08.2022.
//

import UIKit

// MARK: -  MainPresenterProtocol
protocol  MainPresenterProtocol: AnyObject {
    func settingsButtonPressed()
    func startQuickGameButtonPressed()
    func logOutButtonPressed()
    func missionStartGameButtonPressed()
}

// MARK: -  MainPresenter
final class  MainPresenter {
    
    weak var viewController: MainViewController?
    
    private let sceneBuildManager: Buildable
    
    init(sceneBuildManager: Buildable) {
        self.sceneBuildManager = sceneBuildManager
    }
}

//MARK: -  MainPresenterExtension
extension  MainPresenter: MainPresenterProtocol {
    func settingsButtonPressed() {
        let rootViewController = sceneBuildManager.buildSettingsScreen()
        UIApplication.shared.windows.first?.rootViewController = rootViewController
    }
    
    func startQuickGameButtonPressed() {
        print(#function)
    }
    
    func logOutButtonPressed() {
        let rootViewController = sceneBuildManager.buildMenuScreen()
        UIApplication.shared.windows.first?.rootViewController = rootViewController
    }
    
    func missionStartGameButtonPressed() {
        print(#function)
    }
}
