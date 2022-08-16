//
//  GamePresenter.swift
//  ARHitBalls
//
//  Created by Swift Learning on 15.08.2022.
//

// MARK: -  GamePresenterProtocol
protocol  GamePresenterProtocol: AnyObject {
    
}

// MARK: -  GamePresenter
final class  GamePresenter {
    
    weak var viewController: GameViewController?
    
    private let sceneBuildManager: Buildable
    
    init(sceneBuildManager: Buildable) {
        self.sceneBuildManager = sceneBuildManager
    }
}

//MARK: -  GamePresenterExtension
extension  GamePresenter: GamePresenterProtocol {
    
}
