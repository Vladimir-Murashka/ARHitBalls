//
//  SceneBuildManager.swift
//  ARHitBalls
//
//  Created by Swift Learning on 15.08.2022.
//

protocol Buildable {
    func buildSplashScreen() -> SplashViewController
    func buildMenuScreen() -> MenuViewController
    func buildMainScreen(gameType: GameType) -> MainViewController
    func buildSettingsScreen(
        settingType: SettingType,
        selectedKit: KitType
    ) -> SettingsViewController
    func buildGameScreen(
        timerValue: Double,
        levelValue: Int,
        selectedKit: KitType,
        gameType: GameType
    ) -> GameViewController
    func buildIdentifireScreen(type: AuthType) -> IdentifireViewController
    func buildCustomPopUpScreen(
        PopUpType: PopUpType,
        delegate: CustomPopUpDelegate
    ) -> CustomPopUpViewController
}

final class SceneBuildManager {
    
    private let defaultsManager: DefaultsManagerable
    private let alertManager: AlertManagerable
    private let commonAudioManager: AudioManagerable
    private let gameAudioManager: AudioManagerable
    private let soundEffectManager: AudioManagerable
    private let gameService: GameServiceable
    private let authService: AuthServicable
    private let firestore = FirebaseService.shared
    
    init() {
        defaultsManager = DefaultsManager()
        alertManager = AlertManager()
        commonAudioManager = AudioManager()
        gameAudioManager = AudioManager()
        soundEffectManager = AudioManager()
        gameService = GameService(firestore: firestore)
        authService = AuthService(defaultsManager: defaultsManager,
                                  firestore: firestore)
    }
}

extension SceneBuildManager: Buildable {
    func buildSplashScreen() -> SplashViewController {
        let viewController = SplashViewController()
        let presenter = SplashPresenter(
            authService: authService,
            defaultsStorage: defaultsManager,
            sceneBuildManager: self,
            generalBackgroundAudioManager: commonAudioManager,
            firestore: firestore,
            gameService: gameService
        )
        
        viewController.presenter = presenter
        presenter.viewController = viewController
        
        return viewController
    }
    
    func buildMenuScreen() -> MenuViewController {
        let viewController = MenuViewController()
        let presenter = MenuPresenter(sceneBuildManager: self)
        
        viewController.presenter = presenter
        presenter.viewController = viewController
        
        return viewController
    }
    
    func buildMainScreen(gameType: GameType) -> MainViewController {
        let viewController = MainViewController()
        let presenter = MainPresenter(
            sceneBuildManager: self,
            alertManager: alertManager,
            authService: authService,
            generalBackgroundAudioManager: commonAudioManager,
            gameType: gameType,
            gameService: gameService
        )
        
        viewController.presenter = presenter
        presenter.viewController = viewController
        
        return viewController
    }
    
    func buildSettingsScreen(
        settingType: SettingType,
        selectedKit: KitType
    ) -> SettingsViewController {
        let viewController = SettingsViewController()
        let presenter = SettingsPresenter(
            sceneBuildManager: self,
            defaultsStorage: defaultsManager,
            settingType: settingType,
            selectedKit: selectedKit,
            generalBackgroundAudioManager: commonAudioManager
        )
        
        viewController.presenter = presenter
        presenter.viewController = viewController
        
        return viewController
    }
    
    func buildGameScreen(
        timerValue: Double,
        levelValue: Int,
        selectedKit: KitType,
        gameType: GameType
    ) -> GameViewController {
        let viewController = GameViewController()
        let presenter = GamePresenter(
            sceneBuildManager: self,
            defaultsStorage: defaultsManager,
            generalBackgroundAudioManager: commonAudioManager,
            gameAudioManager: gameAudioManager,
            soundEffectManager: soundEffectManager,
            alertManager: alertManager,
            timerValue: timerValue,
            currentLevelValue: levelValue,
            selectedKit: selectedKit,
            gameType: gameType,
            gameServise: gameService
        )
        
        viewController.presenter = presenter
        presenter.viewController = viewController
        
        return viewController
    }
    
    func buildIdentifireScreen(type: AuthType) -> IdentifireViewController {
        let viewController = IdentifireViewController()
        let presenter = IdentifirePresenter(
            sceneBuildManager: self,
            type: type,
            alertManager: alertManager,
            authService: authService,
            firestore: firestore,
            defaultsManager: defaultsManager
        )
        
        viewController.presenter = presenter
        presenter.viewController = viewController
        
        return viewController
    }
    
    func buildCustomPopUpScreen(
        PopUpType: PopUpType,
        delegate: CustomPopUpDelegate
    ) -> CustomPopUpViewController {
        let viewController = CustomPopUpViewController()
        let presenter = CustomPopUpPresenter(
            sceneBuildManager: self,
            PopUpType: PopUpType
        )
        presenter.delegate = delegate
        viewController.presenter = presenter
        presenter.viewController = viewController
        
        return viewController
    }
}
