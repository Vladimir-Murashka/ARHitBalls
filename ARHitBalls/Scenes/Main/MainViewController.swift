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
        let button = UIButton(type: .system)
        let imageQuitGameButton = UIImage(systemName: "house.circle")
        button.setBackgroundImage(
            imageQuitGameButton,
            for: .normal
        )
        button.tintColor = .black
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        button.addTarget(
            self,
            action: #selector(logoutButtonPressed),
            for: .touchUpInside
        )
        return button
    }()
    
    private lazy var settingsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Настройки", for: .normal)
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
            action: #selector(settingsButtonPressed),
            for: .touchUpInside
        )
        return button
    }()
    
    private let topStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        return stackView
    }()
    
    private let titleTimeLabel: InfoLabel = {
        let label = InfoLabel()
        label.text = "Текущее время раунда"
        return label
    }()
    
    private let timeLabel: InfoLabel = {
        let label = InfoLabel()
        label.text = "20"
        return label
    }()
    
    private let timeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 2
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private let titleLevelLabel: InfoLabel = {
        let label = InfoLabel()
        label.text = "Текущий уровень"
        return label
    }()
    
    private let levelLabel: InfoLabel = {
        let label = InfoLabel()
        label.text = "5"
        return label
    }()
    
    private let levelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 12
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private lazy var startQuickGameButton: StartButton = {
        let button = StartButton(type: .system)
        button.setTitle(
            "Быстрая игра",
            for: .normal
        )
        button.titleLabel?.font = .systemFont(ofSize: 30)
        button.addTarget(
            self,
            action: #selector(startQuickGameButtonPressed),
            for: .touchUpInside
        )
        return button
    }()
    
    private lazy var missionStartGameButton: StartButton = {
        let button = StartButton(type: .system)
        button.alpha = 0.5
        button.setTitle(
            "Компания",
            for: .normal
        )
        button.titleLabel?.font = .systemFont(ofSize: 30)
        button.addTarget(
            self,
            action: #selector(missionStartGameButtonPressed),
            for: .touchUpInside
        )
        return button
    }()
    
    private let kitStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 5
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        return stackView
    }()
    
    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 12
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        return stackView
    }()
    
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setupViewController()
    }
    
    // MARK: - Actions
    
    @objc
    private func settingsButtonPressed() {
        settingsButton.pushAnimate { [weak self] in
            self?.presenter?.settingsButtonPressed()
        }
    }
    
    @objc
    private func startQuickGameButtonPressed() {
        startQuickGameButton.pushAnimate { [weak self] in
            self?.presenter?.startQuickGameButtonPressed()
        }
    }
    
    @objc
    private func logoutButtonPressed() {
        logoutButton.pushAnimate { [weak self] in
            self?.presenter?.logoutButtonPressed()
        }
    }
    
    @objc
    private func missionStartGameButtonPressed() {
        missionStartGameButton.pushAnimate { [weak self] in
            self?.presenter?.missionStartGameButtonPressed()
        }
    }
    
    @objc
    private func kitButtonsPressed(sender: UIButton) {
        kitStackView.subviews.forEach {
            $0.alpha = sender == $0 ? 1 : 0.5
        }
        presenter?.kitButtonsPressed(tag: sender.tag)
    }
}

// MARK: - MainViewProtocol Impl

extension MainViewController: MainViewProtocol {}

// MARK: - PrivateMethods

private extension MainViewController {
    func setupViewController() {
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .systemGray
        addSubViews()
        setupKitButtons()
        setupConstraints()
    }
    
    func setupKitButtons() {
        let kitButtons = KitEnum.allCases
        
        kitButtons.enumerated().forEach { index, kit in
            let button = ShotButton()
            button.setupBackgroundImage(named: kit.imageName )
            button.addTarget(
                self,
                action: #selector(kitButtonsPressed),
                for: .touchUpInside
            )
            button.tag = index
            if button.tag == 0 {
                button.alpha = 1
            }
            kitStackView.addArrangedSubview(button)
        }
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
            verticalStackView,
            kitStackView
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
        let kitStackViewHeight: CGFloat = 220
        let kitStackViewWidth: CGFloat = 50
        
        NSLayoutConstraint.activate([
            topStackView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: stackViewOffset
            ),
            topStackView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: stackViewOffset
            ),
            topStackView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -stackViewOffset
            ),
            
            logoutButton.heightAnchor.constraint(equalToConstant: logoutButtonSize),
            logoutButton.widthAnchor.constraint(equalToConstant: logoutButtonSize),
            
            settingsButton.heightAnchor.constraint(equalToConstant: settingButtonHeight),
            settingsButton.widthAnchor.constraint(equalToConstant: settingButtonWidth),
            
            verticalStackView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -stackViewOffset
            ),
            verticalStackView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: stackViewOffset
            ),
            verticalStackView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -stackViewOffset
            ),
            
            kitStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: stackViewOffset),
            kitStackView.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: stackViewOffset),
            kitStackView.heightAnchor.constraint(equalToConstant: kitStackViewHeight),
            kitStackView.widthAnchor.constraint(equalToConstant: kitStackViewWidth),
            
            titleTimeLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: titleWidth),
            titleLevelLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: titleWidth),
            
            timeLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: valueWidth),
            levelLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: valueWidth),
            
            timeStackView.heightAnchor.constraint(equalToConstant: stackViewHeight),
            levelStackView.heightAnchor.constraint(equalToConstant: stackViewHeight),
            missionStartGameButton.heightAnchor.constraint(equalToConstant: buttonHeight),
            startQuickGameButton.heightAnchor.constraint(equalToConstant: buttonHeight),
        ])
    }
}
