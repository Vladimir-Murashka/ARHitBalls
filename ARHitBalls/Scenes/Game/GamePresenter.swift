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
}

// MARK: - GamePresenter

final class GamePresenter {
    weak var viewController: GameViewProtocol?
    
    // MARK: - PrivateProperties
    
    private let sceneBuildManager: Buildable
    private var selectedKit: KitEnum
    private var value: ARObjectable = SportBalls.basketball
    private var selectedItemNumber = 0
    private let timerValue: Double
    private let currentLevelValue: Int
    
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
        timerValue: Double,
        currentLevelValue: Int,
        selectedKit: KitEnum
    ) {
        self.sceneBuildManager = sceneBuildManager
        self.timerValue = timerValue
        self.currentLevelValue = currentLevelValue
        self.selectedKit = selectedKit
    }
}

//MARK: - GamePresenterExtension

extension GamePresenter: GamePresenterProtocol {
    func viewDidLoad() {
        let timerValueText = transformationTimerLabelText(timeValue: timerValue)
        viewController?.updateTimer(text: timerValueText)
        viewController?.updateLevel(text: String(currentLevelValue * 6))
        viewController?.updateSelected(kit: selectedKit)
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
        viewController?.navigationController?.popViewController(animated: true)
    }

    func shotButtonPressed(tag: Int) {
        selectedItemNumber = tag
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
}
