//
//  SettingsPresenter.swift
//  ARHitBalls
//
//  Created by Swift Learning on 15.08.2022.
//

import UIKit

// MARK: - SettingsPresenterProtocol

protocol SettingsPresenterProtocol: AnyObject {}

// MARK: - SettingsPresenter

final class SettingsPresenter {
    weak var viewController: SettingsViewController?
    
    // MARK: - PrivateProperties
    
    private let sceneBuildManager: Buildable
    
    // MARK: - Initializer
    
    init(sceneBuildManager: Buildable) {
        self.sceneBuildManager = sceneBuildManager
    }
}

//MARK: - SettingsPresenterExtension

extension SettingsPresenter: SettingsPresenterProtocol {}
