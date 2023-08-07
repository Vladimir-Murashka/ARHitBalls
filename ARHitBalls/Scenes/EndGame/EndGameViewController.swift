//
//  EndGameViewController.swift
//  ARHitBalls
//
//  Created by Swift Learning on 26.11.2022.
//

import UIKit

// MARK: - EndGameViewProtocol

protocol EndGameViewProtocol: UIViewController {
    func setupExitGameType()
    func setupTimeIsOverType()
    func setupLevelPassedAuthType()
    func setupLevelPassedFreeType()
    func setupLogoutType()
    func setupDeleteAccountType()
    func updateGameValueLabel(level: String, time: String)
}

// MARK: - EndGameViewController

final class EndGameViewController: UIViewController {
    var presenter: EndGamePresenterProtocol?
    
    // MARK: - PrivateProperties
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "LogoS")
        return imageView
    }()
    
    private let blurView: UIVisualEffectView = {
        let blurView = UIVisualEffectView()
        blurView.effect = UIBlurEffect(style: .dark)
        return blurView
    }()
    
    private let attensionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(
            name: "Dela Gothic One",
            size: 24
        ) ?? .systemFont(ofSize: 24)
        label.text = "Покинуть игру!"
        label.textColor = #colorLiteral(red: 0.9568627451, green: 0.7843137255, blue: 0.06666666667, alpha: 1)
        return label
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(
            name: "Dela Gothic One",
            size: 24
        ) ?? .systemFont(ofSize: 24)
        label.text = "Вы уверены?"
        label.textColor = .white
        return label
    }()
    
    private let messageStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var continueButton: MenuButton = {
        let button = MenuButton(type: .system)
        button.setBackgroundImage(
            UIImage(named: "generalButton"),
            for: .normal
        )
        button.setTitle(
            "Продолжить",
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
    
    private lazy var exitButton: MenuButton = {
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
            string: "Выйти в меню",
            attributes: buttonAttributes
         )
        
        button.setAttributedTitle(
            attributeString,
            for: .normal
        )
        button.addTarget(
            self,
            action: #selector(exitButtonPressed),
            for: .touchUpInside
        )
        return button
    }()
    
    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 16
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        return stackView
    }()
    
    private let levelImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "levelImage")
        return imageView
    }()
    
    private let levelInfoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(
            name: "Dela Gothic One",
            size: 18
        ) ?? .systemFont(ofSize: 14)
        label.text = "Уровень"
        return label
    }()
    
    private let levelHorizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 8
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private let levelLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(
            name: "Dela Gothic One",
            size: 24
        ) ?? .systemFont(ofSize: 24)
        label.text = "5"
        return label
    }()
    
    private let levelVerticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 0
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()
    
    private let timeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "timeImage")
        return imageView
    }()
    
    private let timeInfoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(
            name: "Dela Gothic One",
            size: 18
        ) ?? .systemFont(ofSize: 14)
        label.text = "Время    "
        return label
    }()
    
    private let timeHorizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 8
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(
            name: "Dela Gothic One",
            size: 24
        ) ?? .systemFont(ofSize: 24)
        label.text = "01:40"
        return label
    }()
    
    private let timeVerticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 0
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()
    
    private let gameValueStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 50
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private let levelGameValueImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "gameValueBackground")
        return imageView
    }()
    
    private let timeGameValueImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "gameValueBackground")
        return imageView
    }()
    
    private let gameValueBackgroundStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 15
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.axis = .vertical
        return stackView
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        presenter?.viewDidLoad()
    }
    
    // MARK: - Actions

    @objc
    private func continueButtonPressed() {
        continueButton.pushAnimate { [weak self] in
            self?.presenter?.continueButtonPressed()
        }
    }

    @objc
    private func exitButtonPressed() {
        exitButton.pushAnimate { [weak self] in
            self?.presenter?.exitButtonPressed()
        }
    }
}

// MARK: - EndGameViewProtocol Impl

extension EndGameViewController: EndGameViewProtocol {
    func setupExitGameType() {
        gameValueBackgroundStackView.isHidden = true
        gameValueStackView.isHidden = true
    }
    
    func setupTimeIsOverType() {
        gameValueBackgroundStackView.isHidden = true
        gameValueStackView.isHidden = true
        attensionLabel.text = "Время вышло"
        messageLabel.text = "Попробуй еще раз"
        continueButton.setTitle("Перезапустить уровень", for: .normal)
    }
    
    func setupLevelPassedAuthType() {
        attensionLabel.text = "Поздравляем!"
        messageLabel.text = "Уровень пройден"
        continueButton.setTitle("Следующий уровень", for: .normal)
    }
    
    func setupLevelPassedFreeType() {
        gameValueBackgroundStackView.isHidden = true
        gameValueStackView.isHidden = true
        attensionLabel.text = "Поздравляем!"
        messageLabel.text = "Уровень пройден"
        continueButton.setTitle("Перезапустить уровень", for: .normal)
    }
    
    func setupLogoutType() {
        gameValueBackgroundStackView.isHidden = true
        gameValueStackView.isHidden = true
        attensionLabel.text = "Выйти из аккаунта"
        messageLabel.text = "Вы уверены?"
        continueButton.setTitle("Выйти", for: .normal)
        let buttonAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(
                name: "Dela Gothic One",
                size: 16
            ) ?? .systemFont(ofSize: 16),
            .foregroundColor: UIColor.white,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        let attributeString = NSMutableAttributedString(
            string: "Назад",
            attributes: buttonAttributes
         )
        exitButton.setAttributedTitle(
            attributeString,
            for: .normal
        )
    }
    
    func setupDeleteAccountType() {
        gameValueBackgroundStackView.isHidden = true
        gameValueStackView.isHidden = true
        attensionLabel.text = "Удалить аккаунт"
        messageLabel.text = "Вы уверены?"
        continueButton.setTitle("Удалить", for: .normal)
        let buttonAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(
                name: "Dela Gothic One",
                size: 16
            ) ?? .systemFont(ofSize: 16),
            .foregroundColor: UIColor.white,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        let attributeString = NSMutableAttributedString(
            string: "Назад",
            attributes: buttonAttributes
         )
        exitButton.setAttributedTitle(
            attributeString,
            for: .normal
        )
    }
    
    func updateGameValueLabel(level: String, time: String) {
        levelLabel.text = level
        timeLabel.text = time
    }
}

// MARK: - PrivateMethods

private extension EndGameViewController {
    func setupViewController() {
        isModalInPresentation = true
        addSubViews()
        setupConstraints()
    }
    
    func addSubViews() {
        messageStackView.addArrangedSubviews(
            attensionLabel,
            messageLabel
        )
        
        levelHorizontalStackView.addArrangedSubviews(
            levelImageView,
            levelInfoLabel
        )
        
        levelVerticalStackView.addArrangedSubviews(
            levelHorizontalStackView,
            levelLabel
        )
        
        timeHorizontalStackView.addArrangedSubviews(
            timeImageView,
            timeInfoLabel
        )
        
        timeVerticalStackView.addArrangedSubviews(
            timeHorizontalStackView,
            timeLabel
        )
        
        gameValueStackView.addArrangedSubviews(
            levelVerticalStackView,
            timeVerticalStackView
        )
        
        gameValueBackgroundStackView.addArrangedSubviews(
            levelGameValueImageView,
            timeGameValueImageView
        )
        
        buttonStackView.addArrangedSubviews(
            continueButton,
            exitButton
        )
        
        verticalStackView.addArrangedSubviews(
            logoImageView,
            messageStackView,
            gameValueStackView,
            buttonStackView
        )
        
        view.addSubviews(
            blurView,
            gameValueBackgroundStackView,
            verticalStackView
        )
    }
    
    func setupConstraints() {
        let gameValueImageViewHeight: CGFloat = 90
        let gameValueImageViewWidth: CGFloat = 160
        let gameValueStackViewOffset: CGFloat = 8
        let verticalStackViewOffset: CGFloat = 50
        
        NSLayoutConstraint.activate([
            blurView.topAnchor.constraint(equalTo: view.topAnchor),
            blurView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            blurView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            blurView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            levelGameValueImageView.heightAnchor.constraint(equalToConstant: gameValueImageViewHeight),
            levelGameValueImageView.widthAnchor.constraint(equalToConstant: gameValueImageViewWidth),
            
            timeGameValueImageView.heightAnchor.constraint(equalToConstant: gameValueImageViewHeight),
            timeGameValueImageView.widthAnchor.constraint(equalToConstant: gameValueImageViewWidth),
            
            gameValueStackView.topAnchor.constraint(
                equalTo: gameValueBackgroundStackView.topAnchor,
                constant: gameValueStackViewOffset
            ),
            gameValueStackView.leadingAnchor.constraint(
                equalTo: gameValueBackgroundStackView.leadingAnchor,
                constant: gameValueStackViewOffset
            ),
            gameValueStackView.trailingAnchor.constraint(
                equalTo: gameValueBackgroundStackView.trailingAnchor,
                constant: -gameValueStackViewOffset
            ),
            gameValueStackView.bottomAnchor.constraint(
                equalTo: gameValueBackgroundStackView.bottomAnchor,
                constant: -gameValueStackViewOffset
            ),
            
            verticalStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            verticalStackView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: verticalStackViewOffset
            ),
            verticalStackView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -verticalStackViewOffset
            )
        ])
    }
}

