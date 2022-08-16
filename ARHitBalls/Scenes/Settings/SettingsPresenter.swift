//
//  SettingsPresenter.swift
//  ARHitBalls
//
//  Created by Swift Learning on 15.08.2022.
//

// MARK: -  SettingsPresenterProtocol
protocol  SettingsPresenterProtocol: AnyObject {
    
}

// MARK: -  SettingsPresenter
final class  SettingsPresenter {
    
    weak var viewController: SettingsViewController?
    
    private let sceneBuildManager: Buildable
    
    init(sceneBuildManager: Buildable) {
        self.sceneBuildManager = sceneBuildManager
    }
}

//MARK: -  SettingsPresenterExtension
extension  SettingsPresenter: SettingsPresenterProtocol {
    
}
