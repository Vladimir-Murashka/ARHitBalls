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
    func buildRegistrationScreen() -> RegistrationViewController
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
    
    func buildAuthScreen() -> AuthViewController {
        let viewController = AuthViewController()
        let presenter = AuthPresenter(sceneBuildManager: self)
        
        viewController.presenter = presenter
        presenter.viewController = viewController
        
        return viewController
    }
    
    func buildMainScreen() -> MainViewController {
        let viewController = MainViewController()
        let presenter = MainPresenter(sceneBuildManager: self, alertManager: alertManager)
        
        viewController.presenter = presenter
        presenter.viewController = viewController
        
        return viewController
    }
    
    func buildSettingsScreen() -> SettingsViewController {
        let viewController = SettingsViewController()
        let presenter = SettingsPresenter(sceneBuildManager: self, defaultsStorage: defaultsManager)
        
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
    
    func buildRegistrationScreen() -> RegistrationViewController {
        let viewController = RegistrationViewController()
        let presenter = RegistrationPresenter(sceneBuildManager: self)
        
        viewController.presenter = presenter
        presenter.viewController = viewController
        
        return viewController
    }
}
