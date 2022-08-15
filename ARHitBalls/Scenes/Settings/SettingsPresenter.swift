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
    
}

//MARK: -  SettingsPresenterExtension
extension  SettingsPresenter: SettingsPresenterProtocol {
    
}
