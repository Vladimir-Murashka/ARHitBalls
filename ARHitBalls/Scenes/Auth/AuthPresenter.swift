//
//  AuthPresenter.swift
//  ARHitBalls
//
//  Created by Swift Learning on 15.08.2022.
//

// MARK: - AuthPresenterProtocol
protocol AuthPresenterProtocol: AnyObject {
    
}

// MARK: - AuthPresenter
final class AuthPresenter {
    
    weak var viewController: AuthViewController?
    
}

//MARK: - MenuPresenterExtension
extension AuthPresenter: AuthPresenterProtocol {
    
}
