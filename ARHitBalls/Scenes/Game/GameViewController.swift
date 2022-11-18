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
    func updateLevelLabel(text: String)
    func updateProgressView(value: Float)
    func zeroingProgressView()
    func updateSelected(kit: KitEnum)
    func cleanScene()
}

// MARK: - GameViewController

final class GameViewController: UIViewController {
    var presenter: GamePresenterProtocol?
    
    // MARK: - PrivateProperties
    
    private let sceneView = ARSCNView()
    private var selectedKit: KitEnum = .planets
    
    private let quitButtoLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        return label
    }()
    
    private let timerBackgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "timerBackground")
        return imageView
    }()
    
    private let levelBackgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "levelGameBackground")
        return imageView
    }()
    
    private let topBackgroundStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 5
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        return stackView
    }()
    
    private lazy var quitGameButton: UIButton = {
        let button = QuitButton(type: .system)
        button.addTarget(
            self,
            action: #selector(quitGameButtonPressed),
            for: .touchUpInside
        )
        return button
    }()
    
    private let timerLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "timeImageS")
        return imageView
    }()
    
    private let timerLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.text = "00 : 00"
        return label
    }()
    
    private let timerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        return stackView
    }()
    
    private let levelLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "levelImageS")
        return imageView
    }()
    
    private let levelLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.text = "0"
        return label
    }()
    
    private let levelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 5
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    private let topStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 5
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        return stackView
    }()
    
    private let progressLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "progressLogo")
        return imageView
    }()
    
    private let progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .bar)
        progressView.backgroundColor = .white
        progressView.progressTintColor = #colorLiteral(red: 0.1176470588, green: 0.2039215686, blue: 0.4901960784, alpha: 1)
        progressView.progress = 0
        progressView.transform = CGAffineTransformMakeRotation(.pi * 1.5)
        progressView.layer.cornerRadius = 4
        progressView.clipsToBounds = true
        return progressView
    }()
    
    private let lowStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 3
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let aim: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "aim")
        return imageView
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
    
    func updateLevelLabel(text: String) {
        levelLabel.text = text
    }
    
    func updateProgressView(value: Float) {
        let progress = progressView.progress + value
        progressView.setProgress(progress, animated: true)
    }
    
    func zeroingProgressView() {
        progressView.setProgress(0, animated: true)
    }
    
    func updateSelected(kit: KitEnum) {
        selectedKit = kit
    }
    
    func cleanScene() {
        sceneView.scene.rootNode.enumerateChildNodes { (node, stop) in
            node.removeFromParentNode() }
    }
}

// MARK: - PrivateMethods

private extension GameViewController {
    func setupViewController() {
        sceneView.delegate = self
        sceneView.scene.physicsWorld.contactDelegate = self
        addSubViews()
        setupConstraints()
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
            topBackgroundStackView,
            topStackView,
            progressView,
            progressLogoImageView,
            aim,
            lowStackView
        )
        
        timerStackView.addArrangedSubviews(
            timerLogoImageView,
            timerLabel
        )
        
        levelStackView.addArrangedSubviews(
            levelLogoImageView,
            levelLabel
        )
        
        topBackgroundStackView.addArrangedSubviews(
            quitButtoLabel,
            timerBackgroundImageView,
            levelBackgroundImageView
        )
        
        topStackView.addArrangedSubviews(
            quitGameButton,
            timerStackView,
            levelStackView
        )
    }
    
    func setupConstraints() {
        let topStackViewTopOffset: CGFloat = 0
        let topStackViewSideOffset: CGFloat = 16
        let topStackViewTrailingOffset: CGFloat = 35
        let lowStackViewHeight: CGFloat = 55
        let lowStackViewBottomOffset: CGFloat = -8
        let lowStackViewSideOffset: CGFloat = 8
        let quitButtonSide: CGFloat = 52
        let progressViewWidth: CGFloat = 200
        let progressViewHeight: CGFloat = 8
        let progressViewTopOffset: CGFloat = 166
        let progressViewTrailingOffset: CGFloat = 126
        let progressLogoImageViewLeadingOffset: CGFloat = 16
        let progressLogoImageViewTopOffset: CGFloat = 250
        let aimSize: CGFloat = 100

        NSLayoutConstraint.activate([
            quitButtoLabel.heightAnchor.constraint(equalToConstant: quitButtonSide),
            quitButtoLabel.widthAnchor.constraint(equalToConstant: quitButtonSide),
            
            quitGameButton.heightAnchor.constraint(equalToConstant: quitButtonSide),
            quitGameButton.widthAnchor.constraint(equalToConstant: quitButtonSide),
            
            topBackgroundStackView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: topStackViewTopOffset
            ),
            topBackgroundStackView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: topStackViewSideOffset
            ),
            topBackgroundStackView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: -topStackViewSideOffset
            ),
            
            topStackView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: topStackViewTopOffset
            ),
            topStackView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: topStackViewSideOffset
            ),
            topStackView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: -topStackViewTrailingOffset
            ),
            
            progressView.widthAnchor.constraint(equalToConstant: progressViewWidth),
            progressView.heightAnchor.constraint(equalToConstant: progressViewHeight),
            progressView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: progressViewTopOffset
            ),
            progressView.trailingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: progressViewTrailingOffset
            ),
            
            progressLogoImageView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: progressLogoImageViewLeadingOffset
            ),
            progressLogoImageView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: progressLogoImageViewTopOffset
            ),
            
            lowStackView.heightAnchor.constraint(equalToConstant: lowStackViewHeight),
            lowStackView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: lowStackViewBottomOffset
            ),
            lowStackView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: lowStackViewSideOffset
            ),
            lowStackView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: -lowStackViewSideOffset
            ),
            
            sceneView.topAnchor.constraint(equalTo: view.topAnchor),
            sceneView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            sceneView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sceneView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            aim.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            aim.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            aim.widthAnchor.constraint(equalToConstant: aimSize),
            aim.heightAnchor.constraint(equalToConstant: aimSize)
        ])
    }
}

extension GameViewController: ARSCNViewDelegate {}

extension GameViewController: SCNPhysicsContactDelegate {
    func physicsWorld(
        _ world: SCNPhysicsWorld,
        didBegin contact: SCNPhysicsContact
    ) {
        if contact.nodeA.name == contact.nodeB.name {
            DispatchQueue.main.async {
                contact.nodeA.removeFromParentNode()
                contact.nodeB.removeFromParentNode()
                self.presenter?.nodeSound()
                self.presenter?.nodeVibration()
                self.presenter?.nodeContact()
                self.presenter?.levelIsFinished()
            }
        }
    }
}
