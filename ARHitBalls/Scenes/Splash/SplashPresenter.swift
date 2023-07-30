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
    private let firestore: FirebaseServiceProtocol
    private let sceneBuildManager: Buildable
    private let authService: AuthServicable
    private let defaultsStorage: DefaultsManagerable
    private let generalBackgroundAudioManager: AudioManagerable
    private var gameService: GameServiceable
    private var isMusicOn: Bool = true

    // MARK: - Initializer
    
    init(
        authService: AuthServicable,
        defaultsStorage: DefaultsManagerable,
        sceneBuildManager: Buildable,
        generalBackgroundAudioManager: AudioManagerable,
        firestore: FirebaseServiceProtocol,
        gameService: GameServiceable
    ) {
        self.authService = authService
        self.defaultsStorage = defaultsStorage
        self.sceneBuildManager = sceneBuildManager
        self.generalBackgroundAudioManager = generalBackgroundAudioManager
        self.firestore = firestore
        self.gameService = gameService
    }
}

//MARK: - SplashPresenterExtension

extension SplashPresenter: SplashPresenterProtocol {
    func viewDidLoad() {
        generalBackgroundAudioManager.loadSound(
            forResource: "back",
            withExtension: "mp3"
        )
        
        isMusicOn = defaultsStorage.fetchObject(
            type: Bool.self,
            for: .isMusicOn
        ) ?? true
        
        if isMusicOn {
            generalBackgroundAudioManager.play()
        }
        
        if self.authService.isAuth() {
            navigationAfterLogin()
        } else {
            navigationBeforeLogin()
        }
    }
    
    func navigationBeforeLogin() {
        DispatchQueue.main.asyncAfter(
            deadline: .now() + .seconds(5),
            execute: {
                let rootViewController = UINavigationController(
                    rootViewController: self.sceneBuildManager.buildMenuScreen()
                )
                UIApplication.shared.windows.first?.rootViewController = rootViewController
            })
    }
    
    func navigationAfterLogin() {
        DispatchQueue.main.asyncAfter(
            deadline: .now() + .seconds(5),
            execute: {
                self.gameService.getGameModel { [weak self] result in
                    
                    guard let _self = self else {
                        return
                    }
                    
                    guard let _result = result else {
                        return
                    }
                    
                    _self.gameService.changeCurrentGameModel(model: _result)
                    
                    self?.viewController?.endDownloading()
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                        
                        let rootViewController = UINavigationController(
                            rootViewController:
                                _self.sceneBuildManager.buildMainScreen(gameType: .mission)
                        )
                        UIApplication.shared.windows.first?.rootViewController = rootViewController
                    }
                }
            })
    }
}
