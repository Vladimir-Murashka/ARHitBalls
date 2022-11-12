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
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let topImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "topTextField")
        return imageView
    }()
    
    private let middleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "middleTextField")
        return imageView
    }()
    
    private let bottonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "bottomTextField")
        return imageView
    }()
    
    private let imageViewStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var topLabel: UILabel = {
        let label = UILabel()
        label.text = "Настройки"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
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
    
    private lazy var vibrationSwitcher: UISwitch = {
        let switcher = UISwitch()
        switcher.addTarget(
            self,
            action:  #selector(vibrationSwitcherChange),
            for: .valueChanged
        )
        return switcher
    }()
    
    private let vibrationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private let titleSoundEffectsLabel: InfoLabel = {
        let label = InfoLabel()
        label.text = "Звуковые эффекты"
        return label
    }()
    
    private lazy var soundEffectsSwitcher: UISwitch = {
        let switcher = UISwitch()
        switcher.addTarget(
            self,
            action: #selector(soundEffectsSwitcherChange),
            for: .valueChanged
        )
        return switcher
    }()
    
    private let soundEffectsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private let titleMusicLabel: InfoLabel = {
        let label = InfoLabel()
        label.text = "Музыка"
        return label
    }()
    
    private lazy var musicSwitcher: UISwitch = {
        let switcher = UISwitch()
        switcher.addTarget(
            self,
            action: #selector(musicSwitcherChange),
            for: .valueChanged
        )
        return switcher
    }()
    
    private let musicStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
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
        stepper.addTarget(
            self,
            action: #selector(timeStepperPressed),
            for: .valueChanged
        )
        return stepper
    }()
    
    private let timeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
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
        stepper.addTarget(
            self,
            action: #selector(levelStepperPressed),
            for: .valueChanged
        )
        return stepper
    }()
    
    private let levelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        return stackView
    }()
    
    private lazy var startQuickGameButton: StartButton = {
        let button = StartButton(type: .system)
        button.setTitle(
            "Начать",
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
            action: #selector(startQuickGameButtonPressed),
            for: .touchUpInside
        )
        return button
    }()
    
    private let verticalSettigStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
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
        middleImageView.isHidden = true
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
            topLabel,
            imageViewStackView,
            quitSettingButton,
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
        
        imageViewStackView.addArrangedSubviews(
            topImageView,
            middleImageView,
            bottonImageView
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
        let imageViewBackgroundScreenOffset: CGFloat = 0
        let stackViewTopOffset: CGFloat = 160
        let stackViewSideOffset: CGFloat = 16
        let quitButtonLeadingOffset: CGFloat = 16
        let quitButtonTopOffset: CGFloat = 0
        let startQuickGameButtonOffset: CGFloat = 16
        let topLabelOffset: CGFloat = 16
        let verticalSettigStackViewOffset: CGFloat = 25
        let heightStackView: CGFloat = 56
        
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
            
            vibrationStackView.heightAnchor.constraint(equalToConstant: heightStackView),
            soundEffectsStackView.heightAnchor.constraint(equalToConstant: heightStackView),
            musicStackView.heightAnchor.constraint(equalToConstant: heightStackView),
            timeStackView.heightAnchor.constraint(equalToConstant: heightStackView),
            levelStackView.heightAnchor.constraint(equalToConstant: heightStackView),
            
            topImageView.heightAnchor.constraint(equalToConstant: heightStackView),
            middleImageView.heightAnchor.constraint(equalToConstant: heightStackView),
            bottonImageView.heightAnchor.constraint(equalToConstant: heightStackView),
            
            imageViewStackView.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: stackViewTopOffset
            ),
            imageViewStackView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: stackViewSideOffset
            ),
            imageViewStackView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: -stackViewSideOffset
            ),
        
            verticalSettigStackView.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: stackViewTopOffset
            ),
            verticalSettigStackView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: verticalSettigStackViewOffset
            ),
            verticalSettigStackView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: -verticalSettigStackViewOffset
            ),
            
            quitSettingButton.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: quitButtonLeadingOffset
            ),
            quitSettingButton.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: quitButtonTopOffset
            ),
            
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
