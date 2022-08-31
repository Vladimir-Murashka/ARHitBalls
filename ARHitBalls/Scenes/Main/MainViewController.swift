//
//  MainViewController.swift
//  ARHitBalls
//
//  Created by Swift Learning on 15.08.2022.
//

import UIKit

// MARK: - MainViewProtocol

protocol MainViewProtocol: UIViewController {}

// MARK: - MainViewController

final class MainViewController: UIViewController {
    var presenter: MainPresenterProtocol?
    
    // MARK: - PrivateProperties
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton()
        let imageQuitGameButton = UIImage(systemName: "house.circle")
        button.setBackgroundImage(
            imageQuitGameButton,
            for: .normal
        )
        button.tintColor = .black
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(
            self,
            action: #selector(logoutButtonPressed),
            for: .touchUpInside
        )
        return button
    }()
    
    private lazy var settingsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Настройки", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 24)
        button.setTitleColor(
            .white,
            for: .normal
        )
        button.backgroundColor = .black
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(
            self,
            action: #selector(settingsButtonPressed),
            for: .touchUpInside
        )
        return button
    }()
    
    private let topStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let titleTimeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.text = "Текущее время раунда"
        label.backgroundColor = .black
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.text = "20"
        label.backgroundColor = .black
        return label
    }()
    
    private let timeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 2
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private let titleLevelLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.text = "Текущий уровень"
        label.backgroundColor = .black
        return label
    }()
    
    private let levelLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.text = "5"
        label.backgroundColor = .black
        return label
    }()
    
    private let levelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 12
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private lazy var startQuickGameButton: UIButton = {
        let button = UIButton()
        button.setTitle(
            "Быстрая игра",
            for: .normal
        )
        button.titleLabel?.font = .systemFont(ofSize: 30)
        button.setTitleColor(
            .white,
            for: .normal
        )
        button.backgroundColor = .black
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.addTarget(
            self,
            action: #selector(startQuickGameButtonPressed),
            for: .touchUpInside
        )
        return button
    }()
    
    private lazy var missionStartGameButton: UIButton = {
        let button = UIButton()
        button.setTitle(
            "Компания",
            for: .normal
        )
        button.titleLabel?.font = .systemFont(ofSize: 30)
        button.setTitleColor(
            .white,
            for: .normal
        )
        button.backgroundColor = .black
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.alpha = 0.5
        button.addTarget(
            self,
            action: #selector(missionStartGameButtonPressed),
            for: .touchUpInside
        )
        return button
    }()
    
    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 12
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        return stackView
    }()
    
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
    
    // MARK: - Actions
    
    @objc
    private func settingsButtonPressed() {
        presenter?.settingsButtonPressed()
    }
    
    @objc
    private func startQuickGameButtonPressed() {
        presenter?.startQuickGameButtonPressed()
    }
    
    @objc
    private func logoutButtonPressed() {
        presenter?.logoutButtonPressed()
    }
    
    @objc
    private func missionStartGameButtonPressed() {
        presenter?.missionStartGameButtonPressed()
    }
}

// MARK: - MainViewProtocol Impl

extension MainViewController: MainViewProtocol {}

// MARK: - PrivateMethods

private extension MainViewController {
    func setupViewController() {
        view.backgroundColor = .systemGray
        addSubViews()
        setupConstraints()
    }
    
    func addSubViews() {
        topStackView.addArrangedSubviews(
            logoutButton,
            settingsButton
        )
        
        timeStackView.addArrangedSubviews(
            titleTimeLabel,
            timeLabel
        )
        
        levelStackView.addArrangedSubviews(
            titleLevelLabel,
            levelLabel
        )
        
        verticalStackView.addArrangedSubviews(
            timeStackView,
            levelStackView,
            missionStartGameButton,
            startQuickGameButton
        )
        
        view.addSubviews(
            topStackView,
            verticalStackView
        )
    }
    
    func setupConstraints() {
        let stackViewOffset: CGFloat = 16
        let logoutButtonSize: CGFloat = 30
        let titleWidth: CGFloat = 200
        let valueWidth: CGFloat = 60
        let settingButtonHeight: CGFloat = 30
        let settingButtonWidth: CGFloat = 150
        let stackViewHeight: CGFloat = 30
        let buttonHeight: CGFloat = 48
        
        NSLayoutConstraint.activate([
            topStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: stackViewOffset),
            topStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: stackViewOffset),
            topStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -stackViewOffset),
            
            logoutButton.heightAnchor.constraint(equalToConstant: logoutButtonSize),
            logoutButton.widthAnchor.constraint(equalToConstant: logoutButtonSize),
            
            settingsButton.heightAnchor.constraint(equalToConstant: settingButtonHeight),
            settingsButton.widthAnchor.constraint(equalToConstant: settingButtonWidth),
            
            verticalStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -stackViewOffset),
            verticalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: stackViewOffset),
            verticalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -stackViewOffset),
            
            titleTimeLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: titleWidth),
            titleLevelLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: titleWidth),
            
            timeLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: valueWidth),
            levelLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: valueWidth),
            
            timeStackView.heightAnchor.constraint(equalToConstant: stackViewHeight),
            levelStackView.heightAnchor.constraint(equalToConstant: stackViewHeight),
            missionStartGameButton.heightAnchor.constraint(equalToConstant: buttonHeight),
            startQuickGameButton.heightAnchor.constraint(equalToConstant: buttonHeight)
        ])
    }
}
