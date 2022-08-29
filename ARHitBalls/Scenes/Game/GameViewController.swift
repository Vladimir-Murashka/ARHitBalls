//
//  GameViewController.swift
//  ARHitBalls
//
//  Created by Swift Learning on 15.08.2022.
//
import UIKit

// MARK: - GameViewProtocol

protocol GameViewProtocol: UIViewController {}

// MARK: - GameViewController

final class GameViewController: UIViewController {
    var presenter: GamePresenterProtocol?
    
    // MARK: - PrivateProperties
    
    private lazy var quitGameButton: UIButton = {
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
            action: #selector(quitGameButtonPressed),
            for: .touchUpInside
        )
        return button
    }()
    
    private let timerLable: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.text = "00 : 00"
        label.backgroundColor = .black
        return label
    }()
    
    private let numberOfPlanetsOflabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.text = "00"
        label.backgroundColor = .black
        return label
    }()
    
    private let separatorNumbersOfPlanetsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.text = "/"
        label.backgroundColor = .clear
        return label
    }()
    
    private let totalNumberOfPlanetsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.text = "00"
        label.backgroundColor = .black
        return label
    }()
    
    private let numbersOfPlanetsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 4
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private let topStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 5
        stackView.alignment = .fill
        stackView.distribution = .equalCentering
        return stackView
    }()
    
    private lazy var firstShotButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "earthUIImage")
        button.setBackgroundImage(
            image,
            for: .normal
        )
        button.alpha = 0.5
        button.addTarget(
            self,
            action: #selector(firstShotButtonPressed),
            for: .touchUpInside
        )
        return button
    }()
    
    private lazy var secondShotButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "jupiterUIImage")
        button.setBackgroundImage(
            image,
            for: .normal
        )
        button.alpha = 0.5
        button.addTarget(
            self,
            action: #selector(secondShotButtonPressed),
            for: .touchUpInside
        )
        return button
    }()
    
    private lazy var thirdShotButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "marsUIImage")
        button.setBackgroundImage(
            image,
            for: .normal
        )
        button.alpha = 0.5
        button.addTarget(
            self,
            action: #selector(thirdShotButtonPressed),
            for: .touchUpInside
        )
        return button
    }()
    
    private lazy var fourthShotButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "mercuryUIImage")
        button.setBackgroundImage(
            image,
            for: .normal
        )
        button.alpha = 0.5
        button.addTarget(
            self,
            action: #selector(fourthShotButtonPressed),
            for: .touchUpInside
        )
        return button
    }()
    
    private lazy var fifthShotButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "moonUIImage")
        button.setBackgroundImage(
            image,
            for: .normal
        )
        button.alpha = 0.5
        button.addTarget(
            self,
            action: #selector(fifthShotButtonPressed),
            for: .touchUpInside
        )
        return button
    }()
    
    private lazy var sixthShotButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "neptuneUIImage")
        button.setBackgroundImage(
            image,
            for: .normal
        )
        button.alpha = 0.5
        button.addTarget(
            self,
            action: #selector(sixthShotButtonPressed),
            for: .touchUpInside
        )
        return button
    }()
    
    private let lowStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 5
        
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
    
    // MARK: - Actions
    
    @objc
    private func quitGameButtonPressed() {
        presenter?.quitGameButtonPressed()
    }
    
    @objc
    private func firstShotButtonPressed() {
        presenter?.firstShotButtonPressed()
    }
    
    @objc
    private func secondShotButtonPressed() {
        presenter?.secondShotButtonPressed()
    }
    
    @objc
    private func thirdShotButtonPressed() {
        presenter?.thirdShotButtonPressed()
    }
    
    @objc
    private func fourthShotButtonPressed() {
        presenter?.fourthShotButtonPressed()
    }
    
    @objc
    private func fifthShotButtonPressed() {
        presenter?.fourthShotButtonPressed()
    }
    
    @objc
    private func sixthShotButtonPressed() {
        presenter?.sixthShotButtonPressed()
    }
}

// MARK: - GameViewProtocol Impl

extension GameViewController: GameViewProtocol {}

// MARK: - PrivateMethods

private extension GameViewController {
    func setupViewController() {
        view.backgroundColor = .systemGray
        addSubViews()
        setupConstraints()
    }
    
    func addSubViews() {
        view.addSubviews(
            numbersOfPlanetsStackView,
            topStackView,
            lowStackView
        )
        
        numbersOfPlanetsStackView.addArrangedSubviews(
            numberOfPlanetsOflabel,
            separatorNumbersOfPlanetsLabel,
            totalNumberOfPlanetsLabel
        )
        
        topStackView.addArrangedSubviews(
            quitGameButton,
            timerLable,
            numbersOfPlanetsStackView
        )
        
        lowStackView.addArrangedSubviews(
            firstShotButton,
            secondShotButton,
            thirdShotButton,
            fourthShotButton,
            fifthShotButton,
            sixthShotButton
        )
    }
    
    func setupConstraints() {
        let quitButtonSize: CGFloat = 30
        let planetsLabelWidth: CGFloat = 30
        let timerLabelWidth: CGFloat = 80
        let topStackViewTopOffset: CGFloat = 0
        let topStackViewSideOffset: CGFloat = 16
        let lowStackViewHeight: CGFloat = 50
        let lowStackViewLowOffset: CGFloat = 0
        let lowStackViewSideOffset: CGFloat = 16

        NSLayoutConstraint.activate([
            quitGameButton.heightAnchor.constraint(equalToConstant: quitButtonSize),
            quitGameButton.widthAnchor.constraint(equalToConstant: quitButtonSize),
            
            numberOfPlanetsOflabel.widthAnchor.constraint(equalToConstant: planetsLabelWidth),
            totalNumberOfPlanetsLabel.widthAnchor.constraint(equalToConstant: planetsLabelWidth),
    
            timerLable.widthAnchor.constraint(equalToConstant: timerLabelWidth),
            
            topStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topStackViewTopOffset),
            topStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: topStackViewSideOffset),
            topStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -topStackViewSideOffset),
            
            lowStackView.heightAnchor.constraint(equalToConstant: lowStackViewHeight),
            lowStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: lowStackViewLowOffset),
            lowStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: lowStackViewSideOffset),
            lowStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -lowStackViewSideOffset)
        ])
    }
}
