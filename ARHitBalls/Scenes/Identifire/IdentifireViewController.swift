//
//  IdentifireViewController.swift
//  ARHitBalls
//
//  Created by Swift Learning on 16.08.2022.
//

import UIKit

// MARK: - IdentifireViewProtocol

protocol IdentifireViewProtocol: UIViewController {
    func setupAuth()
    func setupRegister()
}

// MARK: - IdentifireViewController

final class IdentifireViewController: UIViewController {
    var presenter: IdentifirePresenterProtocol?
    
    // MARK: - PrivateProperties
    
    private let imageViewBackgroundScreen: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "generalBackground")
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
    
    private lazy var topLabel: UILabel = {
        let label = UILabel()
        label.text = "Введите данные"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private let emailTextField: IdentifireTextField = {
        let textField = IdentifireTextField()
        textField.placeholder = "Электронная почта"
        textField.background = UIImage(named: "topTextField")
        return textField
    }()
    
    private let passwordTextField: IdentifireTextField = {
        let textField = IdentifireTextField()
        textField.placeholder = "Пароль"
        textField.isSecureTextEntry = true
        textField.background = UIImage(named: "bottomTextField")
        return textField
    }()
    
    private let singinStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 0
        stackView.axis = .vertical
        return stackView
    }()
    
    private let retypePasswordTextField: IdentifireTextField = {
        let textField = IdentifireTextField()
        textField.placeholder = "Введите пароль еще раз"
        textField.isSecureTextEntry = true
        textField.background = UIImage(named: "bottomTextField")
        return textField
    }()
    
    private lazy var continueButton: StartButton = {
        let button = StartButton(type: .system)
        button.setTitle(
            "",
            for: .normal
        )
        button.setBackgroundImage(
            UIImage(named: "generalButton"),
            for: .normal
        )
        button.titleLabel?.font = UIFont(
            name: "Dela Gothic One",
            size: 16
        ) ?? .systemFont(ofSize: 16)
        button.addTarget(
            self,
            action: #selector(continueButtonPressed),
            for: .touchUpInside
        )
        return button
    }()
    
    private lazy var googleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(
            UIImage(named: "googleButton"),
            for: .normal
        )
        button.addTarget(
            self,
            action: #selector(googleButtonPressed),
            for: .touchUpInside
        )
        return button
    }()
    
    private lazy var faceBookButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(
            UIImage(named: "fbButton"),
            for: .normal
        )
        button.addTarget(
            self,
            action: #selector(faceBookButtonPressed),
            for: .touchUpInside
        )
        return button
    }()
    
    private lazy var vKButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(
            UIImage(named: "vkButton"),
            for: .normal
        )
        button.addTarget(
            self,
            action: #selector(vKButtonPressed),
            for: .touchUpInside
        )
        return button
    }()
    
    private lazy var appleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(
            UIImage(named: "aButton"),
            for: .normal
        )
        button.addTarget(
            self,
            action: #selector(appleButtonPressed),
            for: .touchUpInside
        )
        return button
    }()
    
    private let bottomStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
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
            self?.presenter?.continueButtonPressed(
                emailTFValue: self?.emailTextField.text,
                passwordTFValue: self?.passwordTextField.text,
                passwordConfirmTFValue: self?.retypePasswordTextField.text
            )
        }
    }
    
    @objc
    private func quitButtonPressed() {
        quitButton.pushAnimate { [weak self] in
            self?.presenter?.quitButtonPressed()
        }
    }
    
    @objc
    private func googleButtonPressed() {
        googleButton.pushAnimate { [weak self] in
            self?.presenter?.googleButtonPressed()
        }
    }
    
    @objc
    private func faceBookButtonPressed() {
        faceBookButton.pushAnimate { [weak self] in
            self?.presenter?.faceBookButtonPressed()
        }
    }
    
    @objc
    private func vKButtonPressed() {
        vKButton.pushAnimate { [weak self] in
            self?.presenter?.vKButtonPressed()
        }
    }
    
    @objc
    private func appleButtonPressed() {
        appleButton.pushAnimate { [weak self] in
            self?.presenter?.appleButtonPressed()
        }
    }
}

// MARK: - IdentifireViewProtocol Impl

extension IdentifireViewController: IdentifireViewProtocol {
    func setupAuth() {
        retypePasswordTextField.isHidden = true
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
        passwordTextField.background = UIImage(named: "middleTextField")
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
            topLabel,
            singinStackView,
            continueButton,
            quitButton,
            bottomStackView
        )
        
        singinStackView.addArrangedSubviews(
            emailTextField,
            passwordTextField,
            retypePasswordTextField
        )
        
        bottomStackView.addArrangedSubviews(
            googleButton,
            faceBookButton,
            vKButton,
            appleButton
        )
    }
    
    func setupConstraints() {
        let imageViewBackgroundScreenOffset: CGFloat = 0
        let textFieldHeight: CGFloat = 56
        let continueButtonBottomOffset: CGFloat = 16
        let singinStackViewOffset: CGFloat = 16
        let singinStackViewTopOffset: CGFloat = 160
        let quitButtonLeadingOffset: CGFloat = 16
        let quitButtonTopOffset: CGFloat = 0
        let topLabelOffset: CGFloat = 16
        let bottomStackViewBottomOffset: CGFloat = 120
        
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
            
            topLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            topLabel.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: topLabelOffset
            ),
            
            emailTextField.heightAnchor.constraint(equalToConstant: textFieldHeight),
            passwordTextField.heightAnchor.constraint(equalToConstant: textFieldHeight),
            retypePasswordTextField.heightAnchor.constraint(equalToConstant: textFieldHeight),
            
            singinStackView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: singinStackViewOffset
            ),
            singinStackView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -singinStackViewOffset
            ),
            singinStackView.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: singinStackViewTopOffset
            ),
            
            continueButton.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: continueButtonBottomOffset
            ),
            continueButton.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -continueButtonBottomOffset
            ),
            continueButton.topAnchor.constraint(
                equalTo: singinStackView.bottomAnchor,
                constant: continueButtonBottomOffset
            ),
            
            quitButton.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: quitButtonLeadingOffset
            ),
            quitButton.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: quitButtonTopOffset
            ),
            
            bottomStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bottomStackView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor,
                constant: -bottomStackViewBottomOffset
            )
        ])
    }
}
