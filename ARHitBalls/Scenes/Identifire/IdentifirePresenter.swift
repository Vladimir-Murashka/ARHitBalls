//
// IdentifirePresenter.swift
//  ARHitBalls
//
//  Created by Swift Learning on 16.08.2022.
//
import FirebaseAuth
import FirebaseCore
import GoogleSignIn

// MARK: -  IdentifirePresenterProtocol

protocol  IdentifirePresenterProtocol: AnyObject {
    func viewDidLoad()
    func continueButtonPressed(
        emailTFValue: String?,
        passwordTFValue: String?,
        passwordConfirmTFValue: String?
    )
    func quitButtonPressed()
    func googleButtonPressed()
    func appleButtonPressed()
}

// MARK: -  IdentifirePresenter

final class  IdentifirePresenter {
    weak var viewController: IdentifireViewController?
    
    // MARK: - PrivateProperties
    private let firestore: FirebaseServiceProtocol
    private let sceneBuildManager: Buildable
    private let type: AuthType
    private let alertManager: AlertManagerable
    private let authService: AuthServicable
    private let defaultsManager: DefaultsManagerable
    // MARK: - Initializer
    
    init(
        sceneBuildManager: Buildable,
        type: AuthType,
        alertManager: AlertManagerable,
        authService: AuthServicable,
        firestore: FirebaseServiceProtocol,
        defaultsManager: DefaultsManagerable
    ) {
        self.sceneBuildManager = sceneBuildManager
        self.type = type
        self.alertManager = alertManager
        self.authService = authService
        self.firestore = firestore
        self.defaultsManager = defaultsManager
    }
}

//MARK: -  IdentifirePresenterExtension

extension  IdentifirePresenter: IdentifirePresenterProtocol {
    func viewDidLoad() {
        type == .auth
        ? viewController?.setupAuth()
        : viewController?.setupRegister()
    }
    
    func continueButtonPressed(
        emailTFValue: String?,
        passwordTFValue: String?,
        passwordConfirmTFValue: String?
    ) {
        
        guard let email = emailTFValue,
              let password = passwordTFValue else {
            return
        }
        
        if type == .auth {
            authUser(email: email, password: password)
        } else {
            guard let passwordConfirm = passwordConfirmTFValue else {
                return
            }
            guard password == passwordConfirm else {
                alertManager.showAlert(
                    fromViewController: viewController,
                    title: "Ошибка",
                    message: "Пароли не совпадают",
                    firstButtonTitle: "Исправить") {}
                return
            }
            createUser(email: email, password: password)
        }
    }
    
    func quitButtonPressed() {
        viewController?.navigationController?.popViewController(animated: false)
    }
    
    func googleButtonPressed() {
        authUserWithGoogle()
    }
    func appleButtonPressed(
    ) {
        authUserWithApple()
    }
}

private extension IdentifirePresenter {
    func authUser(email: String, password: String) {
        let user: LoginUserRequest = LoginUserRequest(
            email: email,
            password: password
        )
        
        authService.loginUser(
            with: user,
            typeAuth: .email,
            viewController: nil
        ) { error in
            if let error = error {
                print(error.localizedDescription)
                self.alertManager.showAlert(
                                    fromViewController: self.viewController,
                                    title: "Ошибка",
                                    message: "Данные не верны",
                                    firstButtonTitle: "Исправить") {}
                return
            }
            
//            let mainViewController = self.sceneBuildManager.buildMainScreen(gameType: .mission)
            let mainViewController = self.sceneBuildManager.buildSplashScreen()
            self.viewController?.navigationController?.pushViewController(
                mainViewController,
                animated: true
            )
            
            self.defaultsManager.saveObject(true, for: .isUserAuth)
            let fbService: FirebaseServiceProtocol = FirebaseService()
            Repository(firebaseService: fbService).getCalculation(userID: self.firestore.getUserID() ) { result in
                switch result {
                case .success(let success):
//                    self.defaultsManager.saveObject(success.level, for: .missionGameLevelValue)
                    print("MODEL GET:", success)
                case .failure(let failure):
                    print(failure)
                    let model = LevelModel(userID: self.firestore.getUserID() , level: Level(level: 1))
                    Repository(firebaseService: fbService).setCalculation(levelModel: model) { result in
                        switch result {
                        case .success(let success):
                            print("MODEL SET:", success)
                        case .failure(let failure):
                            print(failure)
                        }
                    }
                }
            }
        }
    }
    
    func createUser(email: String, password: String) {
        let user: RegisterUserRequest = RegisterUserRequest(
            email: email,
            password: password
        )
        
        authService.registerUser(with: user) { wasRegistered, error in
            if let error = error {
                print(error.localizedDescription)
                self.alertManager.showAlert(
                    fromViewController: self.viewController,
                    title: "Ошибка",
                    message: error.localizedDescription,
                    firstButtonTitle: "OK") {}
                return
            }
//            let mainViewController = self.sceneBuildManager.buildMainScreen(gameType: .mission)
            let mainViewController = self.sceneBuildManager.buildSplashScreen()
            self.viewController?.navigationController?.pushViewController(
                mainViewController,
                animated: true
            )
            
            self.defaultsManager.saveObject(true, for: .isUserAuth)
            let fbService: FirebaseServiceProtocol = FirebaseService()
            let model = LevelModel(userID: self.firestore.getUserID(), level: Level(level: 1))
            Repository(firebaseService: fbService).setCalculation(levelModel: model) { result in
                switch result {
                case .success(let success):
                    print("MODEL SET:", success)
                case .failure(let failure):
                    print(failure)
                }
            }
//            self.defaultsManager.saveObject(1, for: .missionGameLevelValue)
        }
    }
    
    func authUserWithGoogle() {
        self.authService.loginUser(with: nil, typeAuth: .google, viewController: viewController) { error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
//            let mainViewController = self.sceneBuildManager.buildMainScreen(gameType: .mission)
            let mainViewController = self.sceneBuildManager.buildSplashScreen()
            
            guard let viewController = self.viewController else {
                return
            }
            
            viewController.navigationController?.pushViewController(
                mainViewController,
                animated: true
            )
            
            self.defaultsManager.saveObject(true, for: .isUserAuth)
            let fbService: FirebaseServiceProtocol = FirebaseService()
            Repository(firebaseService: fbService).getCalculation(userID: self.firestore.getUserID()) { result in
                switch result {
                case .success(let success):
//                    self.defaultsManager.saveObject(success.level, for: .missionGameLevelValue)
                    print("MODEL GET:", success)
                case .failure(let failure):
                    print(failure)
                    let model = LevelModel(userID: self.firestore.getUserID(), level: Level(level: 1))
//                    self.defaultsManager.saveObject(1, for: .missionGameLevelValue)
                    Repository(firebaseService: fbService).setCalculation(levelModel: model) { result in
                        switch result {
                        case .success(let success):
                            print("MODEL SET:", success)
                        case .failure(let failure):
                            print(failure)
                        }
                    }
                }
            }
        }
    }
    
    func authUserWithApple() {
        authService.loginUser(with: nil,
                              typeAuth: .apple,
                              viewController: nil) { [weak self] error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
//            guard let mainViewController = self?.sceneBuildManager.buildMainScreen(gameType: .mission) else { return }
            guard let _self = self else { return }
            let mainViewController = _self.sceneBuildManager.buildSplashScreen()
            self?.viewController?.navigationController?.pushViewController(
                mainViewController,
                animated: true
            )
            
            self?.defaultsManager.saveObject(true, for: .isUserAuth)
            let fbService: FirebaseServiceProtocol = FirebaseService()
            Repository(firebaseService: fbService).getCalculation(userID: self?.firestore.getUserID() ?? "") { result in
                switch result {
                case .success(let success):
//                    self?.defaultsManager.saveObject(success.level, for: .missionGameLevelValue)
                    print("MODEL GET:", success)
                case .failure(let failure):
                    print(failure)
                    let model = LevelModel(userID: self?.firestore.getUserID() ?? "", level: Level(level: 1))
                    Repository(firebaseService: fbService).setCalculation(levelModel: model) { result in
                        switch result {
                        case .success(let success):
                            print("MODEL SET:", success)
                        case .failure(let failure):
                            print(failure)
                        }
                    }
                }
            }
        }
    }
}
