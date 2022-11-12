//
//  MenuViewController.swift
//  ARHitBalls
//
//  Created by Swift Learning on 15.08.2022.
//

import UIKit

// MARK: - MenuViewProtocol

protocol MenuViewProtocol: UIViewController {}

// MARK: - MenuViewController

final class MenuViewController: UIViewController {
    var presenter: MenuPresenterProtocol?
    
    // MARK: - PrivateProperties
    
    private let imageViewBackgroundScreen: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "generalBackground")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "LogoS")
        return imageView
    }()
    
    private lazy var startButtonWithoutRegister: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(
            UIImage(named: "demoButtonMenu"),
            for: .normal
        )
        button.addTarget(
            self,
            action: #selector(startButtonWithoutRegisterPressed),
            for: .touchUpInside
        )
        return button
    }()
    
    private lazy var authButton: MenuButton = {
        let button = MenuButton(type: .system)
        button.setBackgroundImage(
            UIImage(named: "generalButton"),
            for: .normal
        )
        button.setTitle(
            "Войти",
            for: .normal
        )
        button.titleLabel?.font = UIFont(
            name: "Dela Gothic One",
            size: 16
        ) ?? .systemFont(ofSize: 16)
        button.addTarget(
            self,
            action: #selector(authButtonPressed),
            for: .touchUpInside
        )
        return button
    }()
    
    private lazy var registerButton: MenuButton = {
        let button = MenuButton(type: .system)
        let buttonAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(
                name: "Dela Gothic One",
                size: 16
            ) ?? .systemFont(ofSize: 16),
            .foregroundColor: UIColor.white,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        let attributeString = NSMutableAttributedString(
            string: "Зарегистрироваться",
            attributes: buttonAttributes
         )
        
        button.setAttributedTitle(
            attributeString,
            for: .normal
        )
        button.addTarget(
            self,
            action: #selector(registerButtonPressed),
            for: .touchUpInside
        )
        return button
    }()
    
    private let commonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 16
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        return stackView
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
    
    // MARK: - Actions
    
    @objc
    private func startButtonWithoutRegisterPressed() {
        startButtonWithoutRegister.pushAnimate { [weak self] in
            self?.presenter?.startButtonWithoutRegisterPressed()
        }
    }
    
    @objc
    private func authButtonPressed() {
        authButton.pushAnimate { [weak self] in
            self?.presenter?.authButtonPressed()
        }
    }
    
    @objc
    private func registerButtonPressed() {
        registerButton.pushAnimate { [weak self] in
            self?.presenter?.registerButtonPressed()
        }
    }
}


// MARK: - MenuViewProtocol Impl

extension MenuViewController: MenuViewProtocol {}

// MARK: - PrivateMethods

private extension MenuViewController {
    func setupViewController() {
        addSubViews()
        setupConstraints()
        navigationController?.isNavigationBarHidden = true
    }
    
    func addSubViews() {
        view.addSubviews(
            imageViewBackgroundScreen,
            commonStackView,
            logoImageView,
            startButtonWithoutRegister
        )
        
        commonStackView.addArrangedSubviews(
            authButton,
            registerButton
        )
    }
    
    func setupConstraints() {
        let imageViewBackgroundScreenIndent: CGFloat = 0
        let commonStackViewIndent: CGFloat = 16
        let commonStackViewBottomIndent: CGFloat = 50
        let logoImageViewTopIndent: CGFloat = 52
        let buttonHeightValue: CGFloat = 56
        
        NSLayoutConstraint.activate([
            imageViewBackgroundScreen.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: imageViewBackgroundScreenIndent
            ),
            imageViewBackgroundScreen.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: imageViewBackgroundScreenIndent
            ),
            imageViewBackgroundScreen.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: imageViewBackgroundScreenIndent
            ),
            imageViewBackgroundScreen.bottomAnchor.constraint(
                equalTo: view.bottomAnchor,
                constant: imageViewBackgroundScreenIndent
            ),
            
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: logoImageViewTopIndent
            ),
            
            startButtonWithoutRegister.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButtonWithoutRegister.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            authButton.heightAnchor.constraint(equalToConstant: buttonHeightValue),
            registerButton.heightAnchor.constraint(equalToConstant: buttonHeightValue),
            
            commonStackView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: commonStackViewIndent
            ),
            commonStackView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant:-commonStackViewIndent
            ),
            commonStackView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -commonStackViewBottomIndent
            )
        ])
    }
}
