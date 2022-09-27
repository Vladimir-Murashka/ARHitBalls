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
    func updateLevelValueLabel(
        levelValue: Double,
        levelText: String
    )
    func updateTimeValueLabel(
        timeValue: Double,
        timeText: String
    )
    func setupMainSetting()
    func setupQuickGameSetting()
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
    
    private lazy var quitSettingButton: QuitButton = {
        let button = QuitButton(type: .system)
        button.addTarget(
            self,
            action: #selector(quitSettingsButtonPressed),
            for: .touchUpInside
        )
        return button
    }()
    
    private let titleVibrationLabel: InfoLabel = {
        let label = InfoLabel()
        label.text = "Вибрация"
        return label
    }()
    
    private lazy var vibrationSwitcher: SettingSwitcher = {
        let switcher = SettingSwitcher()
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
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private let titleSoundEffectsLabel: InfoLabel = {
        let label = InfoLabel()
        label.text = "Звуковые эффекты"
        return label
    }()
    
    private lazy var soundEffectsSwitcher: SettingSwitcher = {
        let switcher = SettingSwitcher()
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
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private let titleMusicLabel: InfoLabel = {
        let label = InfoLabel()
        label.text = "Музыка"
        return label
    }()
    
    private lazy var musicSwitcher: SettingSwitcher = {
        let switcher = SettingSwitcher()
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
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private lazy var timeTitleLabel: InfoLabel = {
        let label = InfoLabel()
        label.text = "Время раунда"
        return label
    }()
    
    private lazy var timeValueLabel: UILabel = {
        let label = InfoLabel()
        return label
    }()
    
    private lazy var timeStepper: UIStepper = {
        let stepper = UIStepper()
        stepper.maximumValue = 180
        stepper.minimumValue = 10
        stepper.stepValue = 10
        stepper.backgroundColor = .black
        stepper.layer.cornerRadius = 8
        stepper.addTarget(
            self,
            action: #selector(timeStepperPressed),
            for: .valueChanged
        )
        return stepper
    }()
    
    private let timeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 2
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private let levelTitleLabel: InfoLabel = {
        let label = InfoLabel()
        label.text = "Уровень сложности"
        return label
    }()
    
    private let levelValueLabel: InfoLabel = {
        let label = InfoLabel()
        return label
    }()

    private lazy var levelStepper: UIStepper = {
        let stepper = UIStepper()
        stepper.maximumValue = 20
        stepper.minimumValue = 1
        stepper.value = 0
        stepper.stepValue = 1
        stepper.backgroundColor = .black
        stepper.layer.cornerRadius = 8
        stepper.addTarget(
            self,
            action: #selector(levelStepperPressed),
            for: .valueChanged
        )
        return stepper
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
            "Начать",
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
    
    private let verticalSettigStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
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
    private func vibrationSwitcherChange() {
        presenter?.vibrationSwitcherChange(value: vibrationSwitcher.isOn)
    }
    
    @objc
    private func soundEffectsSwitcherChange() {
        presenter?.soundEffectsSwitcherChange(value: soundEffectsSwitcher.isOn)
    }
    
    @objc
    private func musicSwitcherChange() {
        presenter?.musicSwitcherChange(value: musicSwitcher.isOn)
    }
    
    @objc
    private func quitSettingsButtonPressed() {
        quitSettingButton.pushAnimate { [weak self] in
            self?.presenter?.quitSettingsButtonPressed()
        }
    }
    
    @objc
    private func timeStepperPressed() {
        presenter?.timeStepperPressed(timeValue: timeStepper.value)
    }
    
    @objc
    private func levelStepperPressed() {
        presenter?.levelStepperPressed(levelValue: levelStepper.value)
    }
    
    @objc
    private func startQuickGameButtonPressed() {
        startQuickGameButton.pushAnimate { [weak self] in
            self?.presenter?.startQuickGameButtonPressed()
        }
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
    
    func updateLevelValueLabel(
        levelValue: Double,
        levelText: String
    ) {
        levelStepper.value = levelValue
        levelValueLabel.text = levelText       
    }
    
    func updateTimeValueLabel(
        timeValue: Double,
        timeText: String
    ) {
        timeStepper.value = timeValue
        timeValueLabel.text = timeText
    }
    
    func setupMainSetting() {
        startQuickGameButton.isHidden = true
        timeStackView.isHidden = true
        levelStackView.isHidden = true
    }
    
    func setupQuickGameSetting() {
        vibrationStackView.isHidden = true
        soundEffectsStackView.isHidden = true
        musicStackView.isHidden = true
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
            timeStackView,
            levelStackView,
            verticalSettigStackView,
            startQuickGameButton
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
        
        timeStackView.addArrangedSubviews(
            timeTitleLabel,
            timeValueLabel,
            timeStepper
        )
        
        levelStackView.addArrangedSubviews(
            levelTitleLabel,
            levelValueLabel,
            levelStepper
        )

        verticalSettigStackView.addArrangedSubviews(
            vibrationStackView,
            soundEffectsStackView,
            musicStackView,
            levelStackView,
            timeStackView
        )
    }
    
    func setupConstraints() {
        let titleLabelWidth: CGFloat = 170
        let stackViewTopOffset: CGFloat = 70
        let stackViewSideOffset: CGFloat = 16
        let quitButtonLeadingOffset: CGFloat = 16
        let quitButtonTopOffset: CGFloat = 0
        let quitButtonSize: CGFloat = 30
        let levelValueLabelWidth: CGFloat = 30
        let timeValueLabelWidth: CGFloat = 70
        let startQuickGameButtonOffset: CGFloat = 16
        
        NSLayoutConstraint.activate([
            titleVibrationLabel.widthAnchor.constraint(equalToConstant: titleLabelWidth),
            titleSoundEffectsLabel.widthAnchor.constraint(equalToConstant: titleLabelWidth),
            titleMusicLabel.widthAnchor.constraint(equalToConstant: titleLabelWidth),
            
            levelTitleLabel.widthAnchor.constraint(equalToConstant: titleLabelWidth),
            levelValueLabel.widthAnchor.constraint(equalToConstant: levelValueLabelWidth),
            
            timeTitleLabel.widthAnchor.constraint(equalToConstant: titleLabelWidth),
            timeValueLabel.widthAnchor.constraint(equalToConstant: timeValueLabelWidth),
            
            verticalSettigStackView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: stackViewTopOffset
            ),
            verticalSettigStackView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: stackViewSideOffset
            ),
            verticalSettigStackView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: -stackViewSideOffset
            ),
            
            quitSettingButton.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: quitButtonLeadingOffset
            ),
            quitSettingButton.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: quitButtonTopOffset
            ),
            quitSettingButton.heightAnchor.constraint(equalToConstant: quitButtonSize),
            quitSettingButton.widthAnchor.constraint(equalToConstant: quitButtonSize),
            
            startQuickGameButton.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: startQuickGameButtonOffset
            ),
            startQuickGameButton.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -startQuickGameButtonOffset
            ),
            startQuickGameButton.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -startQuickGameButtonOffset
            )
        ])
    }
}
