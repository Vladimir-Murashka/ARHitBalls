//
//  SceneBuildManager.swift
//  ARHitBalls
//
//  Created by Swift Learning on 15.08.2022.
//

protocol Buildable {
    func buildSplashScreen() -> SplashViewController
    func buildMenuScreen() -> MenuViewController
    func buildMainScreen() -> MainViewController
    func buildSettingsScreen(
        settingType: SettingType,
        selectedKit: KitEnum
    ) -> SettingsViewController
    func buildGameScreen(
        timerValue: Double,
        levelValue: Int,
        selectedKit: KitEnum
    ) -> GameViewController
    func buildIdentifireScreen(type: AuthType) -> IdentifireViewController
}

final class SceneBuildManager {
    
    private let userService: UserServiceable
    private let defaultsManager: DefaultsManagerable
    private let alertManager: AlertManagerable
    
    init() {
        defaultsManager = DefaultsManager()
        userService = UserService(defaultsManager: defaultsManager)
        alertManager = AlertManager()
    }
}

extension SceneBuildManager: Buildable {
    func buildSplashScreen() -> SplashViewController {
        let viewController = SplashViewController()
        let presenter = SplashPresenter(
            userService: userService,
            sceneBuildManager: self
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
    
    func buildMainScreen() -> MainViewController {
        let viewController = MainViewController()
        let presenter = MainPresenter(
            sceneBuildManager: self,
            alertManager: alertManager
        )
        
        viewController.presenter = presenter
        presenter.viewController = viewController
        
        return viewController
    }
    
    func buildSettingsScreen(
        settingType: SettingType,
        selectedKit: KitEnum
    ) -> SettingsViewController {
        let viewController = SettingsViewController()
        let presenter = SettingsPresenter(
            sceneBuildManager: self,
            defaultsStorage: defaultsManager,
            settingType: settingType,
            selectedKit: selectedKit
        )
        
        viewController.presenter = presenter
        presenter.viewController = viewController
        
        return viewController
    }
    
    func buildGameScreen(
        timerValue: Double,
        levelValue: Int,
        selectedKit: KitEnum
    ) -> GameViewController {
        let viewController = GameViewController()
        let presenter = GamePresenter(
            sceneBuildManager: self,
            timerValue: timerValue,
            currentLevelValue: levelValue,
            selectedKit: selectedKit
        )
        
        viewController.presenter = presenter
        presenter.viewController = viewController
        
        return viewController
    }
    
    func buildIdentifireScreen(type: AuthType) -> IdentifireViewController {
        let viewController = IdentifireViewController()
        let presenter = IdentifirePresenter(
            sceneBuildManager: self,
            type: type
        )
        
        viewController.presenter = presenter
        presenter.viewController = viewController
        
        return viewController
    }
}
