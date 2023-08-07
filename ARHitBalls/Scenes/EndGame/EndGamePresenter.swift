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
        switch endGameType {
        case .exitGame:
            viewController?.setupExitGameType()
        case .levelPassedFree:
            viewController?.setupLevelPassedFreeType()
        case .levelPassedAuth:
            viewController?.setupLevelPassedAuthType()
            guard let newGameValue = delegate?.newGameValue?() else {
                return
            }
            viewController?.updateGameValueLabel(level: newGameValue[0], time: newGameValue[1])
        case .timeIsOver:
            viewController?.setupTimeIsOverType()
        case .logout:
            viewController?.setupLogoutType()
        case .deleteAccount:
            viewController?.setupDeleteAccountType()
        }
    }
    
    func continueButtonPressed() {
        viewController?.dismiss(animated: true)
        if endGameType == .exitGame {
            delegate?.continueGame?()
        }
        
        if endGameType == .timeIsOver || endGameType == .levelPassedFree {
            delegate?.restartLevel?()
        }
        
        if endGameType == .levelPassedAuth {
            delegate?.nextLevel?()
        }
        
        if endGameType == .logout {
            delegate?.logout?()
        }
        
        if endGameType == .deleteAccount {
            delegate?.deleteAccount?()
        }
    }
    
    func exitButtonPressed() {
        viewController?.dismiss(animated: true)
        delegate?.exitGame?()
    }
}

