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
    
}

//MARK: -  MainPresenterExtension
extension  MainPresenter: MainPresenterProtocol {
    
}
