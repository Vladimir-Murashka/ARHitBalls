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
    func buildSettingsScreen() -> SettingsViewController
    func buildGameScreen() -> GameViewController
    func buildIdentifireScreen(type: AuthType) -> IdentifireViewController
}

final class SceneBuildManager {
    
    private let userService: UserServiceable
    private let defaultsManager: DefaultsManagerable
    
    init() {
        defaultsManager = DefaultsManager()
        userService = UserService(defaultsManager: defaultsManager)
    }
}

extension SceneBuildManager: Buildable {
    func buildSplashScreen() -> SplashViewController {
        let viewController = SplashViewController()
        let presenter = SplashPresenter(userService: userService, sceneBuildManager: self)
        
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
        let presenter = MainPresenter(sceneBuildManager: self)
        
        viewController.presenter = presenter
        presenter.viewController = viewController
        
        return viewController
    }
    
    func buildSettingsScreen() -> SettingsViewController {
        let viewController = SettingsViewController()
        let presenter = SettingsPresenter(sceneBuildManager: self)
        
        viewController.presenter = presenter
        presenter.viewController = viewController
        
        return viewController
    }
    
    func buildGameScreen() -> GameViewController {
        let viewController = GameViewController()
        let presenter = GamePresenter(sceneBuildManager: self)
        
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
