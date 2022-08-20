//
//  AuthViewController.swift
//  ARHitBalls
//
//  Created by Swift Learning on 15.08.2022.
//
import UIKit

// MARK: - AuthViewProtocol

protocol AuthViewProtocol: UIViewController {}

// MARK: - AuthViewController

final class AuthViewController: UIViewController {
    var presenter: AuthPresenterProtocol?
    
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
        textField.placeholder = "Введите пароль"
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
    
    private let commonLoginStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 20
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var authButton: UIButton = {
        let button = UIButton()
        button.setTitle(
            "Войти",
            for: .normal
        )
        button.titleLabel?.font = .systemFont(ofSize: 24)
        button.setTitleColor(
            .white,
            for: .normal
        )
        button.backgroundColor = .black
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.addTarget(
            self,
            action: #selector(authButtonPressed),
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
    private func authButtonPressed() {
        presenter?.authButtonPressed()
    }
    
    @objc
    private func quitButtonPressed() {
        presenter?.quitButtonPressed()
    }
}

// MARK: - AuthViewProtocol Impl

extension AuthViewController: AuthViewProtocol {}

// MARK: - PrivateMethods

private extension AuthViewController {
    func setupViewController() {
        addSubViews()
        setupConstraints()
    }
    
    func addSubViews() {
        view.addSubviews(
            imageViewBackgroundScreen,
            emailStackView,
            passwordStackView,
            commonLoginStackView,
            authButton,
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

        commonLoginStackView.addArrangedSubviews(
            emailStackView,
            passwordStackView
        )
    }
    
    func setupConstraints() {
        let imageViewBackgroundScreenOffset: CGFloat = 0
        let heightTextField: CGFloat = 30
        let widthAuthButton: CGFloat = 100
        let authButtonBottomOffset: CGFloat = 16
        let commonLoginStackViewIndent: CGFloat = 16
        let quitButtonLeadingOffset: CGFloat = 16
        let quitButtonTopOffset: CGFloat = 0
        let quitButtonSize: CGFloat = 30
       
        NSLayoutConstraint.activate([
            imageViewBackgroundScreen.topAnchor.constraint(equalTo: view.topAnchor, constant: imageViewBackgroundScreenOffset),
            imageViewBackgroundScreen.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: imageViewBackgroundScreenOffset),
            imageViewBackgroundScreen.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: imageViewBackgroundScreenOffset),
            imageViewBackgroundScreen.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: imageViewBackgroundScreenOffset),
            
            commonLoginStackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            commonLoginStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: commonLoginStackViewIndent),
            commonLoginStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -commonLoginStackViewIndent),
            
            emailTextField.heightAnchor.constraint(equalToConstant: heightTextField),
            passwordTextField.heightAnchor.constraint(equalToConstant: heightTextField),
            
            authButton.widthAnchor.constraint(equalToConstant: widthAuthButton),
            authButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            authButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -authButtonBottomOffset),
            
            quitButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: quitButtonLeadingOffset),
            quitButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: quitButtonTopOffset),
            quitButton.heightAnchor.constraint(equalToConstant: quitButtonSize),
            quitButton.widthAnchor.constraint(equalToConstant: quitButtonSize)
        ])
    }
}
