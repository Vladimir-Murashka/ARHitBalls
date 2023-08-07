//
//  CustomPopUpPresenter.swift
//  ARHitBalls
//
//  Created by Swift Learning on 26.11.2022.
//

import UIKit

// MARK: - CustomPopUpPresenterProtocol

protocol CustomPopUpPresenterProtocol: AnyObject {
    func viewDidLoad()
    func continueButtonPressed()
    func exitButtonPressed()
}

// MARK: - CustomPopUpPresenter

final class CustomPopUpPresenter {
    weak var viewController: CustomPopUpViewProtocol?
    weak var delegate: CustomPopUpDelegate?
    
    // MARK: - PrivateProperties
    
    private let sceneBuildManager: Buildable
    private let PopUpType: PopUpType
    
    // MARK: - Initializer
    
    init(
        sceneBuildManager: Buildable,
        PopUpType: PopUpType
    ) {
        self.sceneBuildManager = sceneBuildManager
        self.PopUpType = PopUpType
    }
}

//MARK: - CustomPopUpPresenterExtension

extension CustomPopUpPresenter: CustomPopUpPresenterProtocol {
    func viewDidLoad() {
        switch PopUpType {
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
        if PopUpType == .exitGame {
            delegate?.continueGame?()
        }
        
        if PopUpType == .timeIsOver || PopUpType == .levelPassedFree {
            delegate?.restartLevel?()
        }
        
        if PopUpType == .levelPassedAuth {
            delegate?.nextLevel?()
        }
        
        if PopUpType == .logout {
            delegate?.logout?()
        }
        
        if PopUpType == .deleteAccount {
            delegate?.deleteAccount?()
        }
    }
    
    func exitButtonPressed() {
        viewController?.dismiss(animated: true)
        delegate?.exitGame?()
    }
}

