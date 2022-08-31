//
//  SettingsViewController.swift
//  ARHitBalls
//
//  Created by Swift Learning on 15.08.2022.
//

import UIKit

// MARK: - SettingsViewProtocol

protocol SettingsViewProtocol: UIViewController {
    func updateSwitchersValues(
        vibrationValue: Bool,
        soundValue: Bool,
        musicValue: Bool
    )
}

// MARK: - SettingsViewController

final class SettingsViewController: UIViewController {
    var presenter: SettingsPresenterProtocol?
    
    // MARK: - PrivateProperties
    
    private let imageViewBackgroundScreen: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "settingBackground")
        return imageView
    }()
    
    private lazy var quitSettingButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "arrowshape.turn.up.left.circle.fill")
        button.setBackgroundImage(
            image,
            for: .normal
        )
        button.tintColor = .black
        button.backgroundColor = .white
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        button.addTarget(
            self,
            action: #selector(quitSettingsButtonPressed),
            for: .touchUpInside
        )
        return button
    }()
    
    private let titleVibrationLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.text = "Вибрация"
        label.backgroundColor = .black
        return label
    }()
    
    private lazy var vibrationSwitcher: UISwitch = {
        let switcher = UISwitch()
        switcher.layer.cornerRadius = 15
        switcher.layer.masksToBounds = true
        switcher.backgroundColor = .black
        switcher.isOn = true
        switcher.addTarget(
            self,
            action:  #selector(vibrationSwitcherChange),
            for: .valueChanged
        )
        return switcher
    }()
    
    private let vibrationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 12
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private let titleSoundEffectsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.text = "Звуковые эффекты"
        label.backgroundColor = .black
        return label
    }()
    
    private lazy var soundEffectsSwitcher: UISwitch = {
        let switcher = UISwitch()
        switcher.layer.cornerRadius = 15
        switcher.layer.masksToBounds = true
        switcher.backgroundColor = .black
        switcher.isOn = true
        switcher.addTarget(
            self,
            action: #selector(soundEffectsSwitcherChange),
            for: .valueChanged
        )
        return switcher
    }()
    
    private let soundEffectsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 12
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private let titleMusicLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.text = "Музыка"
        label.backgroundColor = .black
        return label
    }()
    
    private lazy var musicSwitcher: UISwitch = {
        let switcher = UISwitch()
        switcher.layer.cornerRadius = 15
        switcher.layer.masksToBounds = true
        switcher.backgroundColor = .black
        switcher.isOn = true
        switcher.addTarget(
            self,
            action: #selector(musicSwitcherChange),
            for: .valueChanged
        )
        return switcher
    }()
    
    private let musicStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 12
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private let verticalSettigStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        presenter?.viewDidLoad()
    }
    
    //MARK: - Actions
    
    @objc
    private func vibrationSwitcherChange(_ sender: UISwitch) {
        presenter?.vibrationSwitcherChange(sender)
    }
    
    @objc
    private func soundEffectsSwitcherChange(_ sender: UISwitch) {
        presenter?.soundEffectsSwitcherChange(sender)
    }
    
    @objc
    private func musicSwitcherChange(_ sender: UISwitch) {
        presenter?.musicSwitcherChange(sender)
    }
    
    @objc
    private func quitSettingsButtonPressed() {
        presenter?.quitSettingsButtonPressed()
    }
}

// MARK: - SettingsViewProtocol Impl

extension SettingsViewController: SettingsViewProtocol {
    func updateSwitchersValues(
        vibrationValue: Bool,
        soundValue: Bool,
        musicValue: Bool
    ) {
        vibrationSwitcher.isOn = vibrationValue
        soundEffectsSwitcher.isOn = soundValue
        musicSwitcher.isOn = musicValue
    }
}

// MARK: - PrivateMethods

private extension SettingsViewController {
    func setupViewController() {
        addSubViews()
        setupConstraints()
    }
    
    func addSubViews() {
        view.addSubviews(
            imageViewBackgroundScreen,
            quitSettingButton,
            vibrationStackView,
            soundEffectsStackView,
            musicStackView,
            verticalSettigStackView
        )
        
        vibrationStackView.addArrangedSubviews(
            titleVibrationLabel,
            vibrationSwitcher
        )
        
        soundEffectsStackView.addArrangedSubviews(
            titleSoundEffectsLabel,
            soundEffectsSwitcher
        )

        musicStackView.addArrangedSubviews(
            titleMusicLabel,
            musicSwitcher
        )

        verticalSettigStackView.addArrangedSubviews(
            vibrationStackView,
            soundEffectsStackView,
            musicStackView
        )
    }
    
    func setupConstraints() {
        let titleLabelWidth: CGFloat = 170
        let stackViewTopOffset: CGFloat = 70
        let stackViewSideOffset: CGFloat = 16
        let quitButtonLeadingOffset: CGFloat = 16
        let quitButtonTopOffset: CGFloat = 0
        let quitButtonSize: CGFloat = 30
        
        NSLayoutConstraint.activate([
            titleVibrationLabel.widthAnchor.constraint(equalToConstant: titleLabelWidth),
            titleSoundEffectsLabel.widthAnchor.constraint(equalToConstant: titleLabelWidth),
            titleMusicLabel.widthAnchor.constraint(equalToConstant: titleLabelWidth),
            
            verticalSettigStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: stackViewTopOffset),
            verticalSettigStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: stackViewSideOffset),
            verticalSettigStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -stackViewSideOffset),
            
            quitSettingButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: quitButtonLeadingOffset),
            quitSettingButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: quitButtonTopOffset),
            quitSettingButton.heightAnchor.constraint(equalToConstant: quitButtonSize),
            quitSettingButton.widthAnchor.constraint(equalToConstant: quitButtonSize)
        ])
    }
}
