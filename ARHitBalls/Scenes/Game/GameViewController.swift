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
    func addChild(nodeTarget: SCNNode)
    func addChild(nodeShot: SCNNode)
    func getARFrame() -> ARFrame?
}

// MARK: - GameViewController

final class GameViewController: UIViewController {
    var presenter: GamePresenterProtocol?
    
    // MARK: - PrivateProperties
    
    private let sceneView = ARSCNView()
    
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
        presenter?.touchesEnded()
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

extension GameViewController: GameViewProtocol {
    func sessionRun(with configuration: ARConfiguration) {
        sceneView.session.run(configuration)
    }
    
    func sessionPause() {
        sceneView.session.pause()
    }
    
    func addChild(nodeTarget: SCNNode) {
        sceneView.scene.rootNode.addChildNode(nodeTarget)
    }
    
    func addChild(nodeShot: SCNNode) {
        sceneView.scene.rootNode.addChildNode(nodeShot)
    }
    
    func getARFrame() -> ARFrame? {
        let ARFrame = sceneView.session.currentFrame
        return ARFrame
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
            sceneView,
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
            sceneView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension GameViewController: ARSCNViewDelegate {}  // оставить тут или вынести в отдельный файл???

extension GameViewController: SCNPhysicsContactDelegate {      // возможно для вьюхи излишне.
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        if contact.nodeA.name == contact.nodeB.name {
            DispatchQueue.main.async {
                contact.nodeA.removeFromParentNode()
                contact.nodeB.removeFromParentNode()
            }
        }
    }
}
