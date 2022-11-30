//
//  GamePresenter.swift
//  ARHitBalls
//
//  Created by Swift Learning on 15.08.2022.
//

import ARKit

// MARK: - GamePresenterProtocol

protocol GamePresenterProtocol: AnyObject, TimerProtocol {
    func viewDidLoad()
    func viewWillAppear()
    func viewWillDisappear()
    func quitGameButtonPressed()
    func shotButtonPressed(tag: Int)
    func touchesEnded(frame: ARFrame)
    func nodeSound()
    func nodeVibration()
    func nodeContact()
    func levelIsFinished()
}

// MARK: - GamePresenter

final class GamePresenter {
    weak var viewController: GameViewProtocol?
    
    // MARK: - PrivateProperties
    
    private let sceneBuildManager: Buildable
    private let defaultsStorage: DefaultsManagerable
    private let generalBackgroundAudioManager: AudioManagerable
    private let gameAudioManager: AudioManagerable
    private let soundEffectManager: AudioManagerable
    private let alertManager: AlertManagerable
    private let gameType: GameType
    private let gameServise: GameServiceable
    
    private var isSoundEffectOn: Bool = true
    private var isVibrationOn: Bool = true
    private var isMusicOn: Bool = true
    
    private var selectedKit: KitType
    
    private var timer = Timer()
    private let timerValue: Double
    private var currentTimerValue: Double = 0
    
    private var numberOfARItems: Int = 0
    private var totalNumberOfARItems: Int = 0
    
    private var currentLevelValue: Int
    private var selectedItemNumber = 0
    
    private var stepProgressView: Float = 0
    
    private func setKit(_ value: Int) -> ARObjectModel? {
        switch selectedKit {
        case .planets:
            return Planets(rawValue: selectedItemNumber)?.shot
        case .fruits:
            return Fruits(rawValue: selectedItemNumber)?.shot
        case .billiardBalls:
            return BilliardBalls(rawValue: selectedItemNumber)?.shot
        case .sportBalls:
            return SportBalls(rawValue: selectedItemNumber)?.shot
        }
    }
    // MARK: - Initializer
    
    init(
        sceneBuildManager: Buildable,
        defaultsStorage: DefaultsManagerable,
        generalBackgroundAudioManager: AudioManagerable,
        gameAudioManager: AudioManagerable,
        soundEffectManager: AudioManagerable,
        alertManager: AlertManagerable,
        timerValue: Double,
        currentLevelValue: Int,
        selectedKit: KitType,
        gameType: GameType,
        gameServise: GameServiceable
    ) {
        self.sceneBuildManager = sceneBuildManager
        self.defaultsStorage = defaultsStorage
        self.generalBackgroundAudioManager = generalBackgroundAudioManager
        self.gameAudioManager = gameAudioManager
        self.soundEffectManager = soundEffectManager
        self.alertManager = alertManager
        self.timerValue = timerValue
        self.currentLevelValue = currentLevelValue
        self.selectedKit = selectedKit
        self.gameType = gameType
        self.gameServise = gameServise
    }
}

//MARK: - GamePresenterExtension

extension GamePresenter: GamePresenterProtocol {
    func viewDidLoad() {
        
        currentTimerValue = timerValue
        totalNumberOfARItems = currentLevelValue * 6
        
        stepProgressView = 1 / Float(totalNumberOfARItems)
        
        soundEffectManager.loadSound(
            forResource: "hit",
            withExtension: "mp3"
        )
        
        isSoundEffectOn = defaultsStorage.fetchObject(
            type: Bool.self,
            for: .isSoundOn
        ) ?? true
        
        isVibrationOn = defaultsStorage.fetchObject(
            type: Bool.self,
            for: .isVibrationOn
        ) ?? true
        
        isMusicOn = defaultsStorage.fetchObject(
            type: Bool.self,
            for: .isMusicOn
        ) ?? true
        
        gameAudioManager.loadSound(
            forResource: "track",
            withExtension: "mp3"
        )
        
        if isMusicOn {
            gameAudioManager.play()
        }
        
        let timerValueText = transformationTimerLabelText(timeValue: timerValue)
        
        viewController?.updateTimer(text: timerValueText)
        viewController?.updateLevelLabel(text: String(currentLevelValue))
        viewController?.updateSelected(kit: selectedKit)
        startTimer()
        addARObject()
    }
    
    func viewWillAppear() {
        let configuration = ARWorldTrackingConfiguration()
        viewController?.sessionRun(with: configuration)
    }
    
    func viewWillDisappear() {
        viewController?.sessionPause()
    }
    
    func touchesEnded(frame: ARFrame) {
        guard let shot = setKit(selectedItemNumber) else {
            return
        }
        fire(
            shot: shot,
            frame: frame
        )
    }
    
    func quitGameButtonPressed() {
        stopTimer()
        viewController?.present(sceneBuildManager.buildEndGameScreen(endGameType: .exitGame), animated: true)
    }
    
    func shotButtonPressed(tag: Int) {
        selectedItemNumber = tag
    }
    
    func nodeSound() {
        if isSoundEffectOn {
            soundEffectManager.play()
        }
    }
    
    func nodeVibration() {
        if isVibrationOn {
            UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
        }
    }
    
    func nodeContact() {
        numberOfARItems += 1
        viewController?.updateProgressView(value: stepProgressView)
    }
    
    func levelIsFinished() {
        if totalNumberOfARItems == numberOfARItems {
            if gameType == .freeGame {
                stopTimer()
                viewController?.present(sceneBuildManager.buildEndGameScreen(endGameType: .levelPassedFree), animated: true)
//                alertManager.showAlert(
//                    fromViewController: viewController,
//                    title: "Поздравляем",
//                    message: "Уровень пройден",
//                    firstButtonTitle: "Выйти",
//                    firstActionBlock: {
//                        self.viewController?.navigationController?.popViewController(animated: true)
//                        self.gameAudioManager.pause()
//                        self.isMusicOn = self.defaultsStorage.fetchObject(
//                            type: Bool.self,
//                            for: .isMusicOn
//                        ) ?? true
//
//                        if self.isMusicOn {
//                            self.generalBackgroundAudioManager.play()
//                        }
//                    },
//                    secondTitleButton: "Перезапустить уровень") {
//                        self.numberOfARItems = 0
//                        self.totalNumberOfARItems = self.currentLevelValue * 6
//                        self.currentTimerValue = self.timerValue
//                        self.viewController?.zeroingProgressView()
//                        self.viewController?.cleanScene()
//                        self.startTimer()
//                        self.addARObject()
//                    }
            } else {
                viewController?.present(sceneBuildManager.buildEndGameScreen(endGameType: .levelPassedAuth), animated: true)
//                do {
//                    let newGameModel = try gameServise.nextLevel()
//                    self.currentLevelValue = newGameModel.level
//                    self.currentTimerValue = newGameModel.time
//                    self.numberOfARItems = 0
//                    self.totalNumberOfARItems = self.currentLevelValue * 6
//                    self.stepProgressView = 1 / Float(self.totalNumberOfARItems)
//                } catch {
//                    // обработать
//                }
//                stopTimer()
//                alertManager.showAlert(
//                    fromViewController: viewController,
//                    title: "Поздравляем",
//                    message: "Уровень пройден",
//                    firstButtonTitle: "Выйти",
//                    firstActionBlock: {
//                        self.viewController?.navigationController?.popViewController(animated: true)
//                        self.gameAudioManager.pause()
//                        self.isMusicOn = self.defaultsStorage.fetchObject(
//                            type: Bool.self,
//                            for: .isMusicOn
//                        ) ?? true
//
//                        if self.isMusicOn {
//                            self.generalBackgroundAudioManager.play()
//                        }
//                    },
//                    secondTitleButton: "Следующий уровень") {
//                        let newTimerValueText = self.transformationTimerLabelText(timeValue: self.currentTimerValue)
//                        self.viewController?.updateLevelLabel(text: String(self.currentLevelValue))
//                        self.viewController?.updateTimer(text: newTimerValueText)
//                        self.viewController?.zeroingProgressView()
//                        self.viewController?.cleanScene()
//                        self.startTimer()
//                        self.addARObject()
//                    }
            }
        }
    }
}

private extension GamePresenter {
    
    func addARObject() {
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
        
        for item in array {
            let shot = item.shot
            addRandomPisitionARObject(
                number: currentLevelValue,
                object: shot
            )
        }
    }
    
    func addRandomPisitionARObject(
        number: Int,
        object: ARObjectModel
    ) {
        for _ in 1...number {
            let xPos = randomPosition(
                from: -1.5,
                to: 1.5
            )
            let yPos = randomPosition(
                from: -1.5,
                to: 1.5
            )
            let zPos = randomPosition(
                from: -4,
                to: 0
            )
            
            createARObject(
                object: object,
                xPos: xPos,
                yPos: yPos,
                zPos: zPos)
            
        }
    }
    
    func randomPosition(
        from: Float,
        to: Float
    ) -> Float {
        return Float(arc4random()) / Float(UInt32.max) * (from - to) + to
    }
    
    func createARObject(
        object: ARObjectModel,
        xPos: Float,
        yPos: Float,
        zPos: Float
    ) {
        let sphere = SCNSphere(radius: 0.1)
        let objectNode = SCNNode()
        let zPos: Float = -1.5
        
        objectNode.geometry = sphere
        objectNode.position = SCNVector3(
            xPos,
            yPos,
            zPos
        )
        objectNode.name = object.nodeName
        
        let material = SCNMaterial()
        material.diffuse.contents = object.textureImage
        material.locksAmbientWithDiffuse = true
        objectNode.geometry?.materials = [material]
        objectNode.physicsBody = SCNPhysicsBody(
            type: .static,
            shape: nil
        )
        objectNode.physicsBody?.isAffectedByGravity = false
        objectNode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
        objectNode.physicsBody?.contactTestBitMask = CollisionCategory.missleCategory.rawValue
        
        viewController?.addChild(node: objectNode)
    }
    
    func fire(
        shot: ARObjectModel,
        frame: ARFrame
    ) {
        let node = createARProjectile(shot)
        let (direction, position) = getUserVector(frame: frame)
        node.position = position
        let nodeDirection = SCNVector3(
            direction.x*4,
            direction.y*4,
            direction.z*4
        )
        node.physicsBody?.applyForce(
            nodeDirection,
            at: SCNVector3(
                0.1,
                0,
                0
            ),
            asImpulse: true
        )
        viewController?.addChild(node: node)
    }
    
    func createARProjectile(_ myShot: ARObjectModel) -> SCNNode {
        let shot = SCNSphere(radius: 0.03)
        let shotNode = SCNNode()
        shotNode.geometry = shot
        shotNode.physicsBody = SCNPhysicsBody(
            type: .dynamic,
            shape: nil
        )
        shotNode.physicsBody?.isAffectedByGravity = false
        
        let material = SCNMaterial()
        material.diffuse.contents = myShot.textureImage
        material.locksAmbientWithDiffuse = true
        shotNode.geometry?.materials = [material]
        shotNode.name = myShot.nodeName
        shotNode.physicsBody?.categoryBitMask = CollisionCategory.missleCategory.rawValue
        shotNode.physicsBody?.contactTestBitMask = CollisionCategory.targetCategory.rawValue
        
        return shotNode
    }
    
    func getUserVector(frame: ARFrame) -> (SCNVector3, SCNVector3) {
        let mat = SCNMatrix4(frame.camera.transform)
        let dir = SCNVector3(
            -1 * mat.m31,
             -1 * mat.m32,
             -1 * mat.m33
        )
        let pos = SCNVector3(
            mat.m41,
            mat.m42,
            mat.m43
        )
        return (
            dir,
            pos
        )
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(timerCounter),
            userInfo: nil,
            repeats: true
        )
    }
    
    @objc
    func timerCounter() -> Void {
        currentTimerValue -= 1
        let timeString = transformationTimerLabelText(timeValue: currentTimerValue)
        viewController?.updateTimer(text: timeString)
        if currentTimerValue == 0 {
            viewController?.present(sceneBuildManager.buildEndGameScreen(endGameType: .timeIsOver), animated: true)
//            stopTimer()
//            alertManager.showAlert(
//                fromViewController: viewController,
//                title: "Ай яй яй",
//                message: "Время вышло",
//                firstButtonTitle: "Выйти",
//                firstActionBlock: {
//                    self.viewController?.navigationController?.popViewController(animated: true)
//                    self.gameAudioManager.pause()
//                    self.isMusicOn = self.defaultsStorage.fetchObject(
//                        type: Bool.self,
//                        for: .isMusicOn
//                    ) ?? true
//
//                    if self.isMusicOn {
//                        self.generalBackgroundAudioManager.play()
//                    }
//                },
//                secondTitleButton: "Перезапустить уровень") {
//                    self.numberOfARItems = 0
//                    self.totalNumberOfARItems = self.currentLevelValue * 6
//                    self.viewController?.zeroingProgressView()
//                    self.currentTimerValue = self.timerValue
//                    self.viewController?.cleanScene()
//                    self.startTimer()
//                    self.addARObject()
//                }
        }
    }
    
    func stopTimer() {
        timer.invalidate()
    }
}


