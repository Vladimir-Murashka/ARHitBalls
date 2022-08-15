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
    
}

//MARK: -  GamePresenterExtension
extension  GamePresenter: GamePresenterProtocol {
    
}
