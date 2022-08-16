//
//  MainPresenter.swift
//  ARHitBalls
//
//  Created by Swift Learning on 15.08.2022.
//

// MARK: -  MainPresenterProtocol
protocol  MainPresenterProtocol: AnyObject {
    
}

// MARK: -  MainPresenter
final class  MainPresenter {
    
    weak var viewController: MainViewController?
    
    private let sceneBuildManager: Buildable
    
    init(sceneBuildManager: Buildable) {
        self.sceneBuildManager = sceneBuildManager
    }
}

//MARK: -  MainPresenterExtension
extension  MainPresenter: MainPresenterProtocol {
    
}
