//
//  RegistrationViewController.swift
//  ARHitBalls
//
//  Created by Swift Learning on 16.08.2022.
//

import UIKit

// MARK: - RegistrationViewProtocol
protocol RegistrationViewProtocol: UIViewController {
    
}

// MARK: - RegistrationViewController
final class RegistrationViewController: UIViewController {
    
//MARK: PublicProperties
    var presenter: RegistrationPresenterProtocol?
    
//MARK: SubViews
    private lazy var imageViewBackgroundScreen: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "registerBackground")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var registrationButton: UIButton = {
        let button = UIButton()
        button.setTitle("Зарегистрироваться", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 24)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(registrationButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var quitButton: UIButton = {
        let button = UIButton()
        let imageQuitGameButton = UIImage(systemName: "arrowshape.turn.up.left.circle.fill")
        button.setBackgroundImage(imageQuitGameButton, for: .normal)
        button.tintColor = .black
        button.backgroundColor = .white
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(quitButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.text = "Email"
        label.backgroundColor = .black
        return label
    }()
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .black
        textField.textColor = .white
        textField.textAlignment = .center
        textField.placeholder = "Введите email адрес"
        textField.layer.cornerRadius = 8
        textField.layer.masksToBounds = true
        return textField
    }()
    
    private lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.text = "Пароль"
        label.backgroundColor = .black
        return label
    }()
    
    private lazy var passwordTextField: UITextField = {
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
    
    private lazy var retypePasswordLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.text = "Повторите пароль"
        label.backgroundColor = .black
        return label
    }()
    
    private lazy var retypePasswordTextField: UITextField = {
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
    
    private lazy var emailStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 2
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var passwordStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 2
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var retypePasswordStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 2
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var commonSingUpStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 20
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        return stackView
    }()
    
//MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
    
//MARK: OverrideMethods
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
//MARK: @objcFunc
    @objc
    func registrationButtonPressed() {
        presenter?.registrationButtonPressed()
    }
    
    @objc
    func quitButtonPressed() {
        presenter?.quitButtonPressed()
    }
}

// MARK: - RegistrationViewProtocol Impl
extension RegistrationViewController: RegistrationViewProtocol {
    
}

// MARK: - Private Methods

private extension RegistrationViewController {
    func setupViewController() {
        addSubViews()
        setupConstraints()
    }
    
    func addSubViews() {
        view.myAddSubview(imageViewBackgroundScreen)
        view.myAddSubview(emailStackView)
        view.myAddSubview(passwordStackView)
        view.myAddSubview(retypePasswordStackView)
        view.myAddSubview(commonSingUpStackView)
        view.myAddSubview(registrationButton)
        view.myAddSubview(quitButton)
        
        emailStackView.addArrangedSubview(emailLabel)
        emailStackView.addArrangedSubview(emailTextField)
        
        passwordStackView.addArrangedSubview(passwordLabel)
        passwordStackView.addArrangedSubview(passwordTextField)
        
        retypePasswordStackView.addArrangedSubview(retypePasswordLabel)
        retypePasswordStackView.addArrangedSubview(retypePasswordTextField)
        
        commonSingUpStackView.addArrangedSubview(emailStackView)
        commonSingUpStackView.addArrangedSubview(passwordStackView)
        commonSingUpStackView.addArrangedSubview(retypePasswordStackView)
    }
    
    func setupConstraints() {
        let imageViewBackgroundScreenIndent: CGFloat = 0
        let textFieldHeight: CGFloat = 30
        let registrationButtonWidth: CGFloat = 250
        let registrationButtonBottomIndent: CGFloat = 16
        let commonSingUpStackViewIndent: CGFloat = 16
        let quitButtonLeadingIndent: CGFloat = 16
        let quitButtonTopIndent: CGFloat = 0
        let quitButtonHeight: CGFloat = 30
        let quitButtonWidth: CGFloat = 30
        
        NSLayoutConstraint.activate([
            imageViewBackgroundScreen.topAnchor.constraint(equalTo: view.topAnchor, constant: imageViewBackgroundScreenIndent),
            imageViewBackgroundScreen.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: imageViewBackgroundScreenIndent),
            imageViewBackgroundScreen.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: imageViewBackgroundScreenIndent),
            imageViewBackgroundScreen.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: imageViewBackgroundScreenIndent),
            
            emailTextField.heightAnchor.constraint(equalToConstant: textFieldHeight),
            passwordTextField.heightAnchor.constraint(equalToConstant: textFieldHeight),
            retypePasswordTextField.heightAnchor.constraint(equalToConstant: textFieldHeight),
            
            registrationButton.widthAnchor.constraint(equalToConstant: registrationButtonWidth),
            registrationButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            registrationButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -registrationButtonBottomIndent),
            
            commonSingUpStackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            commonSingUpStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: commonSingUpStackViewIndent),
            commonSingUpStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -commonSingUpStackViewIndent),
            
            quitButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: quitButtonLeadingIndent),
            quitButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: quitButtonTopIndent),
            quitButton.heightAnchor.constraint(equalToConstant: quitButtonHeight),
            quitButton.widthAnchor.constraint(equalToConstant: quitButtonWidth)
        ])
    }
}
