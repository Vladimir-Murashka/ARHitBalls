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
    private let defaultsStorage: DefaultsManagerable
    private let generalBackgroundAudioManager: AudioManagerable
    private var isMusicOn: Bool = true
    
    // MARK: - Initializer
    
    init(
        userService: UserServiceable,
        defaultsStorage: DefaultsManagerable,
        sceneBuildManager: Buildable,
        generalBackgroundAudioManager: AudioManagerable
    ) {
        self.userService = userService
        self.defaultsStorage = defaultsStorage
        self.sceneBuildManager = sceneBuildManager
        self.generalBackgroundAudioManager = generalBackgroundAudioManager
    }
}

//MARK: - SplashPresenterExtension

extension SplashPresenter: SplashPresenterProtocol {
    func viewDidLoad() {
        generalBackgroundAudioManager.loadSound(
            forResource: "back",
            withExtension: "mp3"
        )
        
        isMusicOn = defaultsStorage.fetchObject(type: Bool.self, for: .isMusicOn) ?? true
        
        if isMusicOn {
            generalBackgroundAudioManager.play()
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5), execute: {
            let rootViewController = UINavigationController(
                rootViewController: self.userService.isUserAuth()
                ? self.sceneBuildManager.buildMainScreen(gameType: .mission)
                : self.sceneBuildManager.buildMenuScreen()
            )
            UIApplication.shared.windows.first?.rootViewController = rootViewController
        })
    }
}
