//
//  MainViewController.swift
//  ARHitBalls
//
//  Created by Swift Learning on 15.08.2022.
//
import UIKit

// MARK: - MainViewProtocol
protocol MainViewProtocol: UIViewController {
    
}

// MARK: - MainViewController
final class MainViewController: UIViewController {
    
//MARK: PublicProperties
    var presenter: MainPresenterProtocol?
    
//MARK: SubViews
    private lazy var logOutButton: UIButton = {
        let button = UIButton()
        let imageQuitGameButton = UIImage(systemName: "house.circle")
        button.setBackgroundImage(imageQuitGameButton, for: .normal)
        button.tintColor = .black
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(logOutButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let startQuickGameButton: UIButton = {
        let button = UIButton()
        button.setTitle("Быстрая игра", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 30)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(startQuickGameButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var missionStartGameButton: UIButton = {
        let button = UIButton()
        button.setTitle("Компания", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 30)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.alpha = 0.5
        button.addTarget(self, action: #selector(missionStartGameButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var settingsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Настройки", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 24)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(settingsButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let infoTimeLable: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.text = "Текущее время раунда"
        label.backgroundColor = .black
        return label
    }()
    
    private let timeLable: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.text = "20"
        label.backgroundColor = .black
        return label
    }()
    
    private let infolevelLableText: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.text = "Текущий уровень"
        label.backgroundColor = .black
        return label
    }()
    
    private let infolevelLableValue: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.text = "5"
        label.backgroundColor = .black
        return label
    }()
    
    private let infolevelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 12
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private let timeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 2
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private let commonInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 12
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        return stackView
    }()
    
    private let commonButtonsStackView: UIStackView = {
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
    @objc func settingsButtonPressed() {
        presenter?.settingsButtonPressed()
    }
    
    @objc func startQuickGameButtonPressed() {
        presenter?.startQuickGameButtonPressed()
    }
    
    @objc func logOutButtonPressed() {
        presenter?.logOutButtonPressed()
    }
    
    @objc func missionStartGameButtonPressed() {
        presenter?.missionStartGameButtonPressed()
    }
}

// MARK: - MainViewProtocol Impl
extension MainViewController: MainViewProtocol {
    
}

// MARK: - Private Methods
private extension MainViewController {
    func setupViewController() {
        view.backgroundColor = .systemGray
        addSubViews()
        setupConstraints()
    }
    
    func addSubViews() {
        view.myAddSubview(startQuickGameButton)
        view.myAddSubview(missionStartGameButton)
        view.myAddSubview(settingsButton)
        view.myAddSubview(infolevelStackView)
        view.myAddSubview(logOutButton)
        view.myAddSubview(commonButtonsStackView)
        view.myAddSubview(infoTimeLable)
        view.myAddSubview(timeLable)
        view.myAddSubview(timeStackView)
        view.myAddSubview(commonInfoStackView)
        
        timeStackView.addArrangedSubview(infoTimeLable)
        timeStackView.addArrangedSubview(timeLable)
        
        infolevelStackView.addArrangedSubview(infolevelLableText)
        infolevelStackView.addArrangedSubview(infolevelLableValue)
        
        commonInfoStackView.addArrangedSubview(timeStackView)
        commonInfoStackView.addArrangedSubview(infolevelStackView)
        
        commonButtonsStackView.addArrangedSubview(missionStartGameButton)
        commonButtonsStackView.addArrangedSubview(startQuickGameButton)
    }
    
    func setupConstraints() {
        let infoLableTextWidth: CGFloat = 200
        let infoLableValueWidth: CGFloat = 60
        let stackViewIndent: CGFloat = 16
        let settingsButtonIndent: CGFloat = 16
        let stackViewHeight: CGFloat = 30
        
        let logOutButtonLeadingIndent: CGFloat = 16
        let logOutButtonTopIndent: CGFloat = 16
        let logOutButtonHeight: CGFloat = 30
        let logOutButtonWidth: CGFloat = 30
        
        NSLayoutConstraint.activate([
            infolevelLableText.widthAnchor.constraint(greaterThanOrEqualToConstant: infoLableTextWidth),
            infolevelLableValue.widthAnchor.constraint(greaterThanOrEqualToConstant: infoLableValueWidth),
            
            infoTimeLable.widthAnchor.constraint(greaterThanOrEqualToConstant: infoLableTextWidth),
            timeLable.widthAnchor.constraint(greaterThanOrEqualToConstant: infoLableValueWidth),
            
            commonButtonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: stackViewIndent),
            commonButtonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -stackViewIndent),
            commonButtonsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -stackViewIndent),
            
            settingsButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -settingsButtonIndent),
            settingsButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: settingsButtonIndent),
        
            timeStackView.heightAnchor.constraint(equalToConstant: stackViewHeight),
            infolevelStackView.heightAnchor.constraint(equalToConstant: stackViewHeight),
            
            commonInfoStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: stackViewIndent),
            commonInfoStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -stackViewIndent),
            commonInfoStackView.bottomAnchor.constraint(equalTo: commonButtonsStackView.topAnchor, constant: -stackViewIndent),
            
            logOutButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: logOutButtonLeadingIndent),
            logOutButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: logOutButtonTopIndent),
            logOutButton.heightAnchor.constraint(equalToConstant: logOutButtonHeight),
            logOutButton.widthAnchor.constraint(equalToConstant: logOutButtonWidth)
        ])
    }
}
