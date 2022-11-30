//
//  EndGamePresenter.swift
//  ARHitBalls
//
//  Created by Swift Learning on 26.11.2022.
//

import UIKit

// MARK: - EndGamePresenterProtocol

protocol EndGamePresenterProtocol: AnyObject {
    func viewDidLoad()
    func continueButtonPressed()
    func exitButtonPressed()
}

// MARK: - EndGamePresenter

final class EndGamePresenter {
    weak var viewController: EndGameViewProtocol?
    weak var delegate: EndGameDelegate?
    
    // MARK: - PrivateProperties
    
    private let sceneBuildManager: Buildable
    private let endGameType: EndGameType
    
    // MARK: - Initializer
    
    init(
        sceneBuildManager: Buildable,
        endGameType: EndGameType
    ) {
        self.sceneBuildManager = sceneBuildManager
        self.endGameType = endGameType
    }
}

//MARK: - EndGamePresenterExtension

extension EndGamePresenter: EndGamePresenterProtocol {
    func viewDidLoad() {
        if endGameType == .exitGame {
            viewController?.setupExitGameType()
        }
        
        if endGameType == .levelPassedFree {
            viewController?.setupLevelPassedFreeType()
        }
        
        if endGameType == .levelPassedAuth {
            viewController?.setupLevelPassedAuthType()
            guard let newGameValue = delegate?.newGameValue() else {
                return
            }
            viewController?.updateGameValueLabel(level: newGameValue[0], time: newGameValue[1])
        }
        
        if endGameType == .timeIsOver {
            viewController?.setupTimeIsOverType()
        }
    }
    
    func continueButtonPressed() {
        viewController?.dismiss(animated: true)
        if endGameType == .exitGame {
            delegate?.continueGame()
        }
        
        if endGameType == .timeIsOver || endGameType == .levelPassedFree {
            delegate?.restartLevel()
        }
        
        if endGameType == .levelPassedAuth {
            delegate?.nextLevel()
        }
    }
    
    func exitButtonPressed() {
        viewController?.dismiss(animated: true)
        delegate?.exitGame()
    }
}

