//
//  RegistrationPresenter.swift
//  ARHitBalls
//
//  Created by Swift Learning on 16.08.2022.
//

// MARK: -  RegistrationPresenterProtocol

import FirebaseAuth
import FirebaseCore

protocol  IdentifirePresenterProtocol: AnyObject {
    func continueButtonPressed(
        emailTFValue: String?,
        passwordTFValue: String?,
        passwordConfirmTFValue: String?
    )
    func quitButtonPressed()
    func viewDidLoad()
}

// MARK: -  RegistrationPresenter

final class  IdentifirePresenter {
    weak var viewController: IdentifireViewController?
    
    // MARK: - PrivateProperties
    
    private let sceneBuildManager: Buildable
    private let type: AuthType
    private let alertManager: AlertManagerable
    
    // MARK: - Initializer
    
    init(
        sceneBuildManager: Buildable,
        type: AuthType,
        alertManager: AlertManagerable
    ) {
        self.sceneBuildManager = sceneBuildManager
        self.type = type
        self.alertManager = alertManager
    }
}

//MARK: -  RegistrationPresenterExtension

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
              let password = passwordTFValue,
              let passwordConfirm = passwordConfirmTFValue,
              let viewController = self.viewController
        else {
            return
        }
        
        if type == .auth {
            
            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                if error == nil{
                    let mainViewController = self.sceneBuildManager.buildMainScreen()
                    self.viewController?.navigationController?.pushViewController(
                        mainViewController,
                        animated: true
                    )
                } else {
                    
                    self.alertManager.showAlert(
                        fromViewController: viewController,
                        title: "Ошибка",
                        message: "Данные не верны",
                        firstButtonTitle: "Исправить") {}
                }
            }
        } else {
            
            if password != passwordConfirm {
                self.alertManager.showAlert(
                    fromViewController: viewController,
                    title: "Ошибка",
                    message: "Пароли не совпадают",
                    firstButtonTitle: "Исправить") {}
            } else {
                
                Auth.auth().createUser(withEmail: email, password: password){ (user, error) in
                    if error == nil {
                        let mainViewController = self.sceneBuildManager.buildMainScreen()
                        self.viewController?.navigationController?.pushViewController(
                            mainViewController,
                            animated: true
                        )
                    } else {
                        
                        self.alertManager.showAlert(
                            fromViewController: viewController,
                            title: "Ошибка",
                            message: error?.localizedDescription,
                            firstButtonTitle: "OK") {}
                    }
                }
            }
        }
    }

func quitButtonPressed() {
    viewController?.navigationController?.popViewController(animated: false)
    }
}
