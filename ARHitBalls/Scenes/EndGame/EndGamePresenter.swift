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
    var delegate: EndGameDelegate?
    
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
        }
        
        if endGameType == .timeIsOver {
            viewController?.setupTimeIsOverType()
        }
    }
    
    func continueButtonPressed() {
        print(#function)
        viewController?.dismiss(animated: true)
    }
    
    func exitButtonPressed() {
        delegate?.exitGame()
    }
}

