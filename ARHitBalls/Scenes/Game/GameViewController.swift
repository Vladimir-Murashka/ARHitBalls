//
//  GameViewController.swift
//  ARHitBalls
//
//  Created by Swift Learning on 15.08.2022.
//
import ARKit
import SceneKit
import UIKit

// MARK: - GameViewProtocol

protocol GameViewProtocol: UIViewController {
    func sessionRun(with configuration: ARConfiguration)
    func sessionPause()
    func addChild(node: SCNNode)
    func updateTimer(text: String)
    func updateLevel(text: String)
    func updateSelected(kit: KitEnum)
}

// MARK: - GameViewController

final class GameViewController: UIViewController {
    var presenter: GamePresenterProtocol?
    
    // MARK: - PrivateProperties
    
    private let sceneView = ARSCNView()
    private var selectedKit: KitEnum = .planets
    
    private lazy var quitGameButton: UIButton = {
        let button = QuitButton(type: .system)
        button.addTarget(
            self,
            action: #selector(quitGameButtonPressed),
            for: .touchUpInside
        )
        return button
    }()
    
    private let aim: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "aim")
        return imageView
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
        presenter?.viewDidLoad()
        setupViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter?.viewWillDisappear()
    }
    
    override func touchesEnded(
        _ touches: Set<UITouch>,
        with event: UIEvent?
    ) {
        guard let frame = sceneView.session.currentFrame else {
            return
        }
        presenter?.touchesEnded(frame: frame)
    }
    
    // MARK: - Actions
    
    @objc
    private func quitGameButtonPressed() {
        quitGameButton.pushAnimate { [weak self] in
            self?.presenter?.quitGameButtonPressed()
        }
    }
    
    @objc
    private func shotButtonPressed(sender: UIButton) {
        lowStackView.subviews.forEach {
            $0.alpha = sender == $0 ? 1 : 0.5
        }
        presenter?.shotButtonPressed(tag: sender.tag)
    }
}

// MARK: - GameViewProtocol Impl

extension GameViewController: GameViewProtocol {
    func sessionRun(with configuration: ARConfiguration) {
        sceneView.session.run(configuration)
    }
    
    func sessionPause() {
        sceneView.session.pause()
    }
    
    func addChild(node: SCNNode) {
        
        sceneView.scene.rootNode.addChildNode(node)
    }
    
    func updateTimer(text: String) {
        timerLabel.text = text
    }
    
    func updateLevel(text: String) {
        totalNumberOfPlanetsLabel.text = text
    }
    
    func updateSelected(kit: KitEnum) {
        selectedKit = kit
    }
}

// MARK: - PrivateMethods

private extension GameViewController {
    func setupViewController() {
        sceneView.delegate = self
        sceneView.scene.physicsWorld.contactDelegate = self
        addSubViews()
        setupConstraints()
        view.backgroundColor = .systemGray
        setupShotButtons()
    }
    
    func setupShotButtons() {
        var array: [ARObjectable] = []
        
        switch selectedKit {
        case .planets:
            array = Planets.allCases
            
        case .fruits:
            array = Fruits.allCases
            
        case .billiardBalls:
            array = BilliardBalls.allCases
            
        case .sportBalls:
            array = SportBalls.allCases
        }
        
        array.enumerated().forEach { index, planet in
            let button = ShotButton()
            button.setupBackgroundImage(named: planet.shot.buttonImageName)
            button.addTarget(
                self,
                action: #selector(shotButtonPressed),
                for: .touchUpInside
            )
            button.tag = index
            if button.tag == 0 {
                button.alpha = 1
            }
            lowStackView.addArrangedSubview(button)
        }
    }
    
    func addSubViews() {
        view.addSubviews(
            sceneView,
            aim,
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
            lowStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -lowStackViewSideOffset),
            
            sceneView.topAnchor.constraint(equalTo: view.topAnchor),
            sceneView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            sceneView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sceneView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            aim.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            aim.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            aim.widthAnchor.constraint(equalToConstant: 100),
            aim.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}

extension GameViewController: ARSCNViewDelegate {}

extension GameViewController: SCNPhysicsContactDelegate {
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        if contact.nodeA.name == contact.nodeB.name {
            DispatchQueue.main.async {
                contact.nodeA.removeFromParentNode()
                contact.nodeB.removeFromParentNode()
                self.presenter?.nodeSound()
                self.presenter?.nodeVibration()
            }
        }
    }
}
