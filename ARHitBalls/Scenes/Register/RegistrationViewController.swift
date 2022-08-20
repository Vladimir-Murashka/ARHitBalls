//
//  RegistrationViewController.swift
//  ARHitBalls
//
//  Created by Swift Learning on 16.08.2022.
//

import UIKit

// MARK: - RegistrationViewProtocol

protocol RegistrationViewProtocol: UIViewController {}

// MARK: - RegistrationViewController

final class RegistrationViewController: UIViewController {
    var presenter: RegistrationPresenterProtocol?
    
// MARK: - PrivateProperties
    
    private let imageViewBackgroundScreen: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "registerBackground")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var quitButton: UIButton = {
        let button = UIButton()
        let imageQuitGameButton = UIImage(systemName: "arrowshape.turn.up.left.circle.fill")
        button.setBackgroundImage(
            imageQuitGameButton,
            for: .normal
        )
        button.tintColor = .black
        button.backgroundColor = .white
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        button.addTarget(
            self,
            action: #selector(quitButtonPressed),
            for: .touchUpInside
        )
        return button
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.text = "Email"
        label.backgroundColor = .black
        return label
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .black
        textField.textColor = .white
        textField.textAlignment = .center
        textField.placeholder = "Введите email адрес"
        textField.layer.cornerRadius = 8
        textField.layer.masksToBounds = true
        return textField
    }()
    
    private let emailStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 2
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        return stackView
    }()
    
    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.text = "Пароль"
        label.backgroundColor = .black
        return label
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .black
        textField.textColor = .white
        textField.textAlignment = .center
        textField.placeholder = "Придумайте пароль"
        textField.layer.cornerRadius = 8
        textField.layer.masksToBounds = true
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let passwordStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 2
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        return stackView
    }()
    
    private let retypePasswordLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.text = "Повторите пароль"
        label.backgroundColor = .black
        return label
    }()
    
    private let retypePasswordTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .black
        textField.textColor = .white
        textField.textAlignment = .center
        textField.placeholder = "Введите пароль еще раз"
        textField.layer.cornerRadius = 8
        textField.layer.masksToBounds = true
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let retypePasswordStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 2
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        return stackView
    }()
    
    private let commonSingUpStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 20
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var registrationButton: UIButton = {
        let button = UIButton()
        button.setTitle(
            "Зарегистрироваться",
            for: .normal
        )
        button.titleLabel?.font = .systemFont(ofSize: 24)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.addTarget(
            self,
            action: #selector(registrationButtonPressed),
            for: .touchUpInside
        )
        return button
    }()
    
//MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
    
//MARK: - OverrideMethods
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
// MARK: - Actions
    
    @objc
    private func registrationButtonPressed() {
        presenter?.registrationButtonPressed()
    }
    
    @objc
    private func quitButtonPressed() {
        presenter?.quitButtonPressed()
    }
}

// MARK: - RegistrationViewProtocol Impl

extension RegistrationViewController: RegistrationViewProtocol {}

// MARK: - PrivateMethods

private extension RegistrationViewController {
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
            registrationButton,
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
            imageViewBackgroundScreen.topAnchor.constraint(equalTo: view.topAnchor, constant: imageViewBackgroundScreenOffset),
            imageViewBackgroundScreen.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: imageViewBackgroundScreenOffset),
            imageViewBackgroundScreen.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: imageViewBackgroundScreenOffset),
            imageViewBackgroundScreen.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: imageViewBackgroundScreenOffset),
            
            emailTextField.heightAnchor.constraint(equalToConstant: textFieldHeight),
            passwordTextField.heightAnchor.constraint(equalToConstant: textFieldHeight),
            retypePasswordTextField.heightAnchor.constraint(equalToConstant: textFieldHeight),
            
            registrationButton.widthAnchor.constraint(equalToConstant: registrationButtonWidth),
            registrationButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            registrationButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -registrationButtonBottomOffset),
            
            commonSingUpStackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            commonSingUpStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: commonSingUpStackViewOffset),
            commonSingUpStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -commonSingUpStackViewOffset),
            
            quitButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: quitButtonLeadingOffset),
            quitButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: quitButtonTopOffset),
            quitButton.heightAnchor.constraint(equalToConstant: quitButtonSize),
            quitButton.widthAnchor.constraint(equalToConstant: quitButtonSize)
        ])
    }
}
