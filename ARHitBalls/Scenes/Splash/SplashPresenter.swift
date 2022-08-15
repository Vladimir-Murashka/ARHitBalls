//
//  SplashPresenter.swift
//  ARHitBalls
//
//  Created by Swift Learning on 15.08.2022.
//

// MARK: - SplashPresenterProtocol
protocol SplashPresenterProtocol: AnyObject {
    
}

// MARK: - SplashPresenter
final class SplashPresenter {
    
    weak var viewController: SplashViewController?
    
}

//MARK: - SplashPresenterExtension
extension SplashPresenter: SplashPresenterProtocol {
    
}
