//
//  SplashPresenter.swift
//  ARHitBalls
//
//  Created by Swift Learning on 15.08.2022.
//

import UIKit

// MARK: - SplashPresenterProtocol

protocol SplashPresenterProtocol: AnyObject {
    func viewDidLoad()
}

// MARK: - SplashPresenter

final class SplashPresenter {
    weak var viewController: SplashViewProtocol?
    
    // MARK: - PrivateProperties
    
    private let sceneBuildManager: Buildable
    private let userService: UserServiceable
    
    // MARK: - Initializer
    
    init(
        userService: UserServiceable,
        sceneBuildManager: Buildable
    ) {
        self.userService = userService
        self.sceneBuildManager = sceneBuildManager
    }
}

//MARK: - SplashPresenterExtension

extension SplashPresenter: SplashPresenterProtocol {
    func viewDidLoad() {
        userService.logout()
        //userService.registerUser()
        
        let rootViewController = UINavigationController(
            rootViewController: userService.isUserAuth()
            ? sceneBuildManager.buildMainScreen()
            : sceneBuildManager.buildMenuScreen()
        )
        UIApplication.shared.windows.first?.rootViewController = rootViewController
    }
}
