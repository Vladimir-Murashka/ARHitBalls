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
    
    private let timerLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.text = "00 : 00"
        label.backgroundColor = .black
        return label
    }()
    
    private let numberOfPlanetslabel: UILabel = {
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
    private func shotButtonPressed(sender: UIButton) {
        presenter?.shotButtonPressed(tag: sender.tag)
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
        setupShotButtons()
    }
    
    func setupShotButtons() {
        let planets = [
            "earthUIImage",
            "jupiterUIImage",
            "marsUIImage",
            "mercuryUIImage",
            "moonUIImage",
            "neptuneUIImage"
        ]
        
        planets.enumerated().forEach { index, imageName in
            let button = ShotButton()
            button.setupBackgroundImage(named: imageName)
            button.addTarget(
                self,
                action: #selector(shotButtonPressed),
                for: .touchUpInside
            )
            button.tag = index
            
            lowStackView.addArrangedSubview(button)
        }
    }
    
    func addSubViews() {
        view.addSubviews(
            numbersOfPlanetsStackView,
            topStackView,
            lowStackView
        )
        
        numbersOfPlanetsStackView.addArrangedSubviews(
            numberOfPlanetslabel,
            separatorNumbersOfPlanetsLabel,
            totalNumberOfPlanetsLabel
        )
        
        topStackView.addArrangedSubviews(
            quitGameButton,
            timerLabel,
            numbersOfPlanetsStackView
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
            
            numberOfPlanetslabel.widthAnchor.constraint(equalToConstant: planetsLabelWidth),
            totalNumberOfPlanetsLabel.widthAnchor.constraint(equalToConstant: planetsLabelWidth),
    
            timerLabel.widthAnchor.constraint(equalToConstant: timerLabelWidth),
            
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
