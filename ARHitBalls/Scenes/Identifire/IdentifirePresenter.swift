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
//    func faceBookButtonPressed()
//    func vKButtonPressed()
    func appleButtonPressed()
}

// MARK: -  IdentifirePresenter

final class  IdentifirePresenter {
    weak var viewController: IdentifireViewController?
    
    // MARK: - PrivateProperties
    
    private let sceneBuildManager: Buildable
    private let type: AuthType
    private let alertManager: AlertManagerable
    private let userService: UserServiceable
    private let authService: AuthServicable
    // MARK: - Initializer
    
    init(
        sceneBuildManager: Buildable,
        type: AuthType,
        alertManager: AlertManagerable,
        userService: UserServiceable,
        authService: AuthServicable
    ) {
        self.sceneBuildManager = sceneBuildManager
        self.type = type
        self.alertManager = alertManager
        self.userService = userService
        self.authService = authService
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
            
            let mainViewController = self.sceneBuildManager.buildMainScreen(gameType: .mission)
            self.viewController?.navigationController?.pushViewController(
                mainViewController,
                animated: true
            )
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
            let mainViewController = self.sceneBuildManager.buildMainScreen(gameType: .mission)
            self.viewController?.navigationController?.pushViewController(
                mainViewController,
                animated: true
            )
        }
    }
    
    func authUserWithGoogle() {
        self.authService.loginUser(with: nil, typeAuth: .google, viewController: viewController) { error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            let mainViewController = self.sceneBuildManager.buildMainScreen(gameType: .mission)
            
            guard let viewController = self.viewController else {
                return
            }
            
            viewController.navigationController?.pushViewController(
                mainViewController,
                animated: true
            )

        }
    }
    
    func authUserWithApple() {
        authService.loginUser(with: nil,
                              typeAuth: .apple,
                              viewController: nil) { error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            let mainViewController = self.sceneBuildManager.buildMainScreen(gameType: .mission)
            self.viewController?.navigationController?.pushViewController(
                mainViewController,
                animated: true
            )

        }
    }
}
