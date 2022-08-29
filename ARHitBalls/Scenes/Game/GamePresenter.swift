//
//  GamePresenter.swift
//  ARHitBalls
//
//  Created by Swift Learning on 15.08.2022.
//

import UIKit

// MARK: - GamePresenterProtocol

protocol GamePresenterProtocol: AnyObject {
    func quitGameButtonPressed()
    func firstShotButtonPressed()
    func secondShotButtonPressed()
    func thirdShotButtonPressed()
    func fourthShotButtonPressed()
    func fifthShotButtonPressed()
    func sixthShotButtonPressed()
}

// MARK: - GamePresenter

final class GamePresenter {
    weak var viewController: GameViewController?
    
    // MARK: - PrivateProperties
    
    private let sceneBuildManager: Buildable
    
    // MARK: - Initializer
    
    init(sceneBuildManager: Buildable) {
        self.sceneBuildManager = sceneBuildManager
    }
}

//MARK: - GamePresenterExtension

extension GamePresenter: GamePresenterProtocol {
    func quitGameButtonPressed() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
    func firstShotButtonPressed() {}
    
    func secondShotButtonPressed() {}
    
    func thirdShotButtonPressed() {}
    
    func fourthShotButtonPressed() {}
    
    func fifthShotButtonPressed() {}
    
    func sixthShotButtonPressed() {}
}
