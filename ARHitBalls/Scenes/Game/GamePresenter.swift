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
    func getCoordinatesOfAllNodes(from rootNode: SCNNode) -> [SCNVector3]
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
    private var timerValue: Double
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
        viewController?.present(
            sceneBuildManager.buildCustomPopUpScreen(
                PopUpType: .exitGame,
                delegate: self
            ),
            animated: true
        )
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
                viewController?.present(
                    sceneBuildManager.buildCustomPopUpScreen(
                        PopUpType: .levelPassedFree,
                        delegate: self
                    ),
                    animated: true
                )
            } else {
                viewController?.present(
                    sceneBuildManager.buildCustomPopUpScreen(
                        PopUpType: .levelPassedAuth,
                        delegate: self
                    ),
                    animated: true
                )
                do {
                    let newGameModel = try gameServise.nextLevel()
                    currentLevelValue = newGameModel.level
                    currentTimerValue = newGameModel.time
                    timerValue = newGameModel.time
                    numberOfARItems = 0
                    totalNumberOfARItems = currentLevelValue * 6
                    stepProgressView = 1 / Float(totalNumberOfARItems)
                } catch {
                    // обработать
                }
                stopTimer()
            }
        }
    }
    
    func getCoordinatesOfAllNodes(from rootNode: SCNNode) -> [SCNVector3] {
        var coordinates = [SCNVector3]()
        
        func traverse(node: SCNNode) {
            coordinates.append(node.position)  // Добавляем позицию текущего нода в список координат.
            for child in node.childNodes {
                traverse(node: child)  // Рекурсивно вызываем функцию для всех дочерних нодов.
            }
        }
        
        traverse(node: rootNode)
        return coordinates
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
            var xPos: Float
            var yPos: Float
            var zPos: Float
            repeat {
                xPos = randomPosition(
                    from: -2,
                    to: 2
                )
                yPos = randomPosition(
                    from: -2,
                    to: 2
                )
                zPos = randomPosition(
                    from: -2,
                    to: 2
                )
            } while !checkPosition(
                x: xPos,
                y: yPos,
                z: zPos
            )
            
            createARObject(
                object: object,
                xPos: xPos,
                yPos: yPos,
                zPos: zPos)
        }
        
    }
    
    func checkPosition(x: Float, y: Float, z: Float) -> Bool {
        guard let nodes = viewController?.getCoordinateOfAllNodes() else {
            return false
        }
        
        for i in nodes {
            let dx = x - i.x
            let dy = y - i.y
            let dz = z - i.z
            let result = sqrt(dx*dx + dy*dy + dz*dz)
            if result > 0 && result <= 0.2 {
                return false
            }
        }
        return true
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
            viewController?.present(
                sceneBuildManager.buildCustomPopUpScreen(
                    PopUpType: .timeIsOver,
                    delegate: self
                ),
                animated: true
            )
            stopTimer()
        }
    }
    
    func stopTimer() {
        timer.invalidate()
    }
}

extension GamePresenter: CustomPopUpDelegate {
    func continueGame() {
       startTimer()
    }
    
    func exitGame() {
        viewController?.navigationController?.popViewController(animated: true)
        gameAudioManager.pause()
        isMusicOn = defaultsStorage.fetchObject(
            type: Bool.self,
            for: .isMusicOn
        ) ?? true
        
        if isMusicOn {
            generalBackgroundAudioManager.play()
        }
    }
    
    func restartLevel() {
        numberOfARItems = 0
        totalNumberOfARItems = currentLevelValue * 6
        viewController?.zeroingProgressView()
        currentTimerValue = timerValue + 1
        viewController?.cleanScene()
        startTimer()
        addARObject()
    }
    
    func nextLevel() {
        let newTimerValueText = transformationTimerLabelText(timeValue: currentTimerValue)
        viewController?.updateLevelLabel(text: String(currentLevelValue))
        viewController?.updateTimer(text: newTimerValueText)
        viewController?.zeroingProgressView()
        viewController?.cleanScene()
        startTimer()
        addARObject()
    }
    
    func newGameValue() -> [String] {
        let newTimerValueText = transformationTimerLabelText(timeValue: timerValue - currentTimerValue)
        return [String(currentLevelValue), newTimerValueText]
    }
}
