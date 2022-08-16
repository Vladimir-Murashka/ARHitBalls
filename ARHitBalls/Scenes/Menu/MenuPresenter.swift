//
//  MenuPresenter.swift
//  ARHitBalls
//
//  Created by Swift Learning on 15.08.2022.
//

// MARK: - MenuPresenterProtocol
protocol MenuPresenterProtocol: AnyObject {
    
}

// MARK: - MenuPresenter
final class MenuPresenter {
    
    weak var viewController: MenuViewController?
    
    private let sceneBuildManager: Buildable
    
    init(sceneBuildManager: Buildable) {
        self.sceneBuildManager = sceneBuildManager
    }
}

//MARK: - MenuPresenterExtension
extension MenuPresenter: MenuPresenterProtocol {
    
}
