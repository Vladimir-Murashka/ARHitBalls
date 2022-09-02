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
    func shotButtonPressed(tag: Int)
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
    
    func shotButtonPressed(tag: Int) {
        switch tag {
        case 0:
            break
        case 1:
            break
        case 2:
            break
        case 3:
            break
        case 4:
            break
        case 5:
            break
        default:
            break
        }
    }
}
