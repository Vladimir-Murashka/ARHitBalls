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
    
    weak var viewController: SplashViewController?
    
    private let sceneBuildManager: Buildable
    private let userService: UserServiceable
    
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

        let rootViewController = userService.isUserAuth()
        ? sceneBuildManager.buildMainScreen()
        : sceneBuildManager.buildMenuScreen()
        
        UIApplication.shared.windows.first?.rootViewController = rootViewController
    }
}
