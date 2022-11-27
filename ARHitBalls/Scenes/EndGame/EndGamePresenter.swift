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
    
    // MARK: - PrivateProperties
    
    private let sceneBuildManager: Buildable
    
    // MARK: - Initializer
    
    init(
        sceneBuildManager: Buildable
    ) {
        self.sceneBuildManager = sceneBuildManager
    }
}

//MARK: - EndGamePresenterExtension

extension EndGamePresenter: EndGamePresenterProtocol {
    func viewDidLoad() {}
    
    func continueButtonPressed() {
        print(#function)
        viewController?.dismiss(animated: true)
    }
    
    func exitButtonPressed() {
        print(#function)
        viewController?.dismiss(animated: true)
    }
}

