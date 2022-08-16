//
//  MenuViewController.swift
//  ARHitBalls
//
//  Created by Swift Learning on 15.08.2022.
//

import UIKit

// MARK: - MenuViewProtocol
protocol MenuViewProtocol: UIViewController {
    
}

// MARK: - MenuViewController
final class MenuViewController: UIViewController {
    
//MARK: PublicProperties
    var presenter: MenuPresenterProtocol?
    
//MARK: SubViews
    private let imageViewBackgroundScreen: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "registerBackground")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var startButtonWithoutRegister: UIButton = {
        let button = UIButton()
        button.setTitle("Играть без регистрации", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(startButtonWithoutRegisterPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var authButton: UIButton = {
        let button = UIButton()
        button.setTitle("Войти", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(authButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Регистрация", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(registerButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let commonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 12
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        return stackView
    }()
    
    
//MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
    
//MARK: @objcFunc
    @objc
    func startButtonWithoutRegisterPressed() {
        presenter?.startButtonWithoutRegisterPressed()
    }

    @objc
    func authButtonPressed() {
        presenter?.authButtonPressed()
    }
        
    @objc
    func registerButtonPressed() {
        presenter?.registerButtonPressed()
    }
    
}


// MARK: - MenuViewProtocol Impl
    extension MenuViewController: MenuViewProtocol {
        
    }
    
// MARK: - Private Methods

private extension MenuViewController {
    func setupViewController() {
        view.backgroundColor = .yellow
        addSubViews()
        setupConstraints()
    }
    
    func addSubViews() {
        view.myAddSubview(imageViewBackgroundScreen)
        view.myAddSubview(commonStackView)
        
        commonStackView.addArrangedSubview(startButtonWithoutRegister)
        commonStackView.addArrangedSubview(authButton)
        commonStackView.addArrangedSubview(registerButton)
    }
    
    func setupConstraints() {
        let imageViewBackgroundScreenIndent: CGFloat = 0
        let commonStackViewIndent: CGFloat = 16
        
        NSLayoutConstraint.activate([
            imageViewBackgroundScreen.topAnchor.constraint(equalTo: view.topAnchor, constant: imageViewBackgroundScreenIndent),
            imageViewBackgroundScreen.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: imageViewBackgroundScreenIndent),
            imageViewBackgroundScreen.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: imageViewBackgroundScreenIndent),
            imageViewBackgroundScreen.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: imageViewBackgroundScreenIndent),
            
            commonStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: commonStackViewIndent),
            commonStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant:-commonStackViewIndent),
            commonStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -commonStackViewIndent),
        ])
    }
    
}
