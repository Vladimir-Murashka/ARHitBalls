//
//  SceneBuildManager.swift
//  ARHitBalls
//
//  Created by Swift Learning on 15.08.2022.
//



protocol Buildable {
    func buildSplashScreen() -> SplashViewController
    func buildMenuScreen() -> MenuViewController
    func buildAuthScreen() -> AuthViewController
    func buildMainScreen() -> MainViewController
    func buildSettingsScreen() -> SettingsViewController
    func buildGameScreen() -> GameViewController
}

final class SceneBuildManager {

    init() {
    }
}

extension SceneBuildManager: Buildable {
    func buildSplashScreen() -> SplashViewController {
        let viewController = SplashViewController()
        let presenter = SplashPresenter()
        
        viewController.presenter = presenter
        presenter.viewController = viewController
        
        return viewController
    }
    
    func buildMenuScreen() -> MenuViewController {
        let viewController = MenuViewController()
        let presenter = MenuPresenter()
        
        viewController.presenter = presenter
        presenter.viewController = viewController
        
        return viewController
    }
    
    func buildAuthScreen() -> AuthViewController {
        let viewController = AuthViewController()
        let presenter = AuthPresenter()
        
        viewController.presenter = presenter
        presenter.viewController = viewController
        
        return viewController
    }
    
    func buildMainScreen() -> MainViewController {
        let viewController = MainViewController()
        let presenter = MainPresenter()
        
        viewController.presenter = presenter
        presenter.viewController = viewController
        
        return viewController
    }
    
    func buildSettingsScreen() -> SettingsViewController {
        let viewController = SettingsViewController()
        let presenter = SettingsPresenter()
        
        viewController.presenter = presenter
        presenter.viewController = viewController
        
        return viewController
    }
    
    func buildGameScreen() -> GameViewController {
        let viewController = GameViewController()
        let presenter = GamePresenter()
        
        viewController.presenter = presenter
        presenter.viewController = viewController
        
        return viewController
    }
}
