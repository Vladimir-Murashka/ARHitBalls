//
//  RegistrationViewController.swift
//  ARHitBalls
//
//  Created by Swift Learning on 16.08.2022.
//

import UIKit

// MARK: - RegistrationViewProtocol

protocol IdentifireViewProtocol: UIViewController {
    func setupAuth()
    func setupRegister()
}

// MARK: - RegistrationViewController

final class IdentifireViewController: UIViewController {
    var presenter: IdentifirePresenterProtocol?
    
    // MARK: - PrivateProperties
    
    private let imageViewBackgroundScreen: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "registerBackground")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var quitButton: QuitButton = {
        let button = QuitButton(type: .system)
        button.addTarget(
            self,
            action: #selector(quitButtonPressed),
            for: .touchUpInside
        )
        return button
    }()
    
    private let emailLabel: IdentifireLabel = {
        let label = IdentifireLabel()
        label.text = "Email"
        return label
    }()
    
    private let emailTextField: IdentifireTextField = {
        let textField = IdentifireTextField()
        textField.placeholder = "Введите email адрес"
        return textField
    }()
    
    private let emailStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 2
        stackView.axis = .vertical
        return stackView
    }()
    
    private let passwordLabel: IdentifireLabel = {
        let label = IdentifireLabel()
        label.text = "Пароль"
        return label
    }()
    
    private let passwordTextField: IdentifireTextField = {
        let textField = IdentifireTextField()
        textField.placeholder = "Введите пароль"
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let passwordStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 2
        stackView.axis = .vertical
        return stackView
    }()
    
    private let retypePasswordLabel: IdentifireLabel = {
        let label = IdentifireLabel()
        label.text = "Повторите пароль"
        return label
    }()
    
    private let retypePasswordTextField: IdentifireTextField = {
        let textField = IdentifireTextField()
        textField.placeholder = "Введите пароль еще раз"
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let retypePasswordStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 2
        stackView.axis = .vertical
        return stackView
    }()
    
    private let commonSingUpStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 20
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var continueButton: StartButton = {
        let button = StartButton(type: .system)
        button.setTitle(
            "",
            for: .normal
        )
        button.titleLabel?.font = .systemFont(ofSize: 24)
        button.addTarget(
            self,
            action: #selector(continueButtonPressed),
            for: .touchUpInside
        )
        return button
    }()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        presenter?.viewDidLoad()
    }
    
    //MARK: - OverrideMethods
    
    override func touchesBegan(
        _ touches: Set<UITouch>,
        with event: UIEvent?
    ) {
        self.view.endEditing(true)
    }
    
    // MARK: - Actions
    
    @objc
    private func continueButtonPressed() {
        continueButton.pushAnimate { [weak self] in
            self?.presenter?.continueButtonPressed()
        }
    }
    
    @objc
    private func quitButtonPressed() {
        quitButton.pushAnimate { [weak self] in
            self?.presenter?.quitButtonPressed()
        }
    }
}

// MARK: - RegistrationViewProtocol Impl

extension IdentifireViewController: IdentifireViewProtocol {
    func setupAuth() {
        retypePasswordStackView.isHidden = true
        continueButton.setTitle(
            "Войти",
            for: .normal
        )
    }
    
    func setupRegister() {
        continueButton.setTitle(
            "Зарегистрироваться",
            for: .normal
        )
        passwordTextField.placeholder = "Придумайте пароль"
    }
}

// MARK: - PrivateMethods

private extension IdentifireViewController {
    func setupViewController() {
        addSubViews()
        setupConstraints()
    }
    
    func addSubViews() {
        view.addSubviews(
            imageViewBackgroundScreen,
            emailStackView,
            passwordStackView,
            retypePasswordStackView,
            commonSingUpStackView,
            continueButton,
            quitButton
        )
        
        emailStackView.addArrangedSubviews(
            emailLabel,
            emailTextField
        )
        
        passwordStackView.addArrangedSubviews(
            passwordLabel,
            passwordTextField
        )
        
        retypePasswordStackView.addArrangedSubviews(
            retypePasswordLabel,
            retypePasswordTextField
        )
        
        commonSingUpStackView.addArrangedSubviews(
            emailStackView,
            passwordStackView,
            retypePasswordStackView
        )
    }
    
    func setupConstraints() {
        let imageViewBackgroundScreenOffset: CGFloat = 0
        let textFieldHeight: CGFloat = 30
        let registrationButtonWidth: CGFloat = 250
        let registrationButtonBottomOffset: CGFloat = 16
        let commonSingUpStackViewOffset: CGFloat = 16
        let quitButtonLeadingOffset: CGFloat = 16
        let quitButtonTopOffset: CGFloat = 0
        let quitButtonSize: CGFloat = 30
        
        NSLayoutConstraint.activate([
            imageViewBackgroundScreen.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: imageViewBackgroundScreenOffset
            ),
            imageViewBackgroundScreen.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: imageViewBackgroundScreenOffset
            ),
            imageViewBackgroundScreen.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: imageViewBackgroundScreenOffset
            ),
            imageViewBackgroundScreen.bottomAnchor.constraint(
                equalTo: view.bottomAnchor,
                constant: imageViewBackgroundScreenOffset
            ),
            
            emailTextField.heightAnchor.constraint(equalToConstant: textFieldHeight),
            passwordTextField.heightAnchor.constraint(equalToConstant: textFieldHeight),
            retypePasswordTextField.heightAnchor.constraint(equalToConstant: textFieldHeight),
            
            continueButton.widthAnchor.constraint(equalToConstant: registrationButtonWidth),
            continueButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            continueButton.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -registrationButtonBottomOffset
            ),
            
            commonSingUpStackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            commonSingUpStackView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: commonSingUpStackViewOffset
            ),
            commonSingUpStackView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: -commonSingUpStackViewOffset
            ),
            
            quitButton.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: quitButtonLeadingOffset
            ),
            quitButton.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: quitButtonTopOffset
            ),
            quitButton.heightAnchor.constraint(equalToConstant: quitButtonSize),
            quitButton.widthAnchor.constraint(equalToConstant: quitButtonSize)
        ])
    }
}
