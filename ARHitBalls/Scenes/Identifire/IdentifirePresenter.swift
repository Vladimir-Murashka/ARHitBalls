//
// IdentifirePresenter.swift
//  ARHitBalls
//
//  Created by Swift Learning on 16.08.2022.
//

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
    func faceBookButtonPressed()
    func vKButtonPressed()
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
    
    // MARK: - Initializer
    
    init(
        sceneBuildManager: Buildable,
        type: AuthType,
        alertManager: AlertManagerable,
        userService: UserServiceable
    ) {
        self.sceneBuildManager = sceneBuildManager
        self.type = type
        self.alertManager = alertManager
        self.userService = userService
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
    
    func googleButtonPressed() {}
    
    func faceBookButtonPressed() {}
    
    func vKButtonPressed() {}
    
    func appleButtonPressed() {}
}

private extension IdentifirePresenter {
    func authUser(email: String, password: String) {
        userService.authUser(
            email: email,
            password: password
        ) { [weak self] result in
            switch result {
            case .success:
                guard let mainViewController = self?.sceneBuildManager.buildMainScreen(gameType: .mission) else {
                    return
                }
                self?.viewController?.navigationController?.pushViewController(
                    mainViewController,
                    animated: true
                )
                
            case .failure(_):
                self?.alertManager.showAlert(
                    fromViewController: self?.viewController,
                    title: "Ошибка",
                    message: "Данные не верны",
                    firstButtonTitle: "Исправить") {}
            }
        }
    }
    
    func createUser(email: String, password: String) {
        userService.registerUser(
            email: email,
            password: password
        ) { [weak self] result in
            switch result {
            case .success:
                guard let mainViewController = self?.sceneBuildManager.buildMainScreen(gameType: .mission) else {
                    return
                }
                self?.viewController?.navigationController?.pushViewController(
                    mainViewController,
                    animated: true
                )
                
            case let .failure(error):
                self?.alertManager.showAlert(
                    fromViewController: self?.viewController,
                    title: "Ошибка",
                    message: error.localizedDescription,
                    firstButtonTitle: "OK") {}
            }
        }
    }
}
