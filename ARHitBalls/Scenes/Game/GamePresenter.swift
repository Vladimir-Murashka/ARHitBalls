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
    private var selectPlanet: PlanetsTexturesEnum = .earth
    private let timerValue: Double
    private let currentLevelValue: Int
    
    // MARK: - Initializer
    
    init(
        sceneBuildManager: Buildable,
        timerValue: Double,
        currentLevelValue: Int
    ) {
        self.sceneBuildManager = sceneBuildManager
        self.timerValue = timerValue
        self.currentLevelValue = currentLevelValue
    }
}

//MARK: - GamePresenterExtension

extension GamePresenter: GamePresenterProtocol {
    func viewDidLoad() {
        let timerValueText = transformationTimerLabelText(timeValue: timerValue)
        viewController?.updateTimer(text: timerValueText)
        viewController?.updateLevel(text: String(currentLevelValue * 6))
        addPlanets()
    }
    
    func viewWillAppear() {
        let configuration = ARWorldTrackingConfiguration()
        viewController?.sessionRun(with: configuration)
    }
    
    func viewWillDisappear() {
        viewController?.sessionPause()
    }
    
    func touchesEnded(frame: ARFrame) {
        fire(
            planet: selectPlanet,
            frame: frame
        )
    }
    
    func quitGameButtonPressed() {
        viewController?.navigationController?.popViewController(animated: true)
    }

    func shotButtonPressed(tag: Int) {
        switch tag {
        case 0:
            selectPlanet = .earth
        case 1:
            selectPlanet = .jupiter
        case 2:
            selectPlanet = .mars
        case 3:
            selectPlanet = .mercury
        case 4:
            selectPlanet = .moon
        case 5:
            selectPlanet = .neptune
        default:
            break
        }
    }
}

private extension GamePresenter {
    func addPlanets() {
        let planets = PlanetsTexturesEnum.allCases
        for planet in planets {
            addRandomPisitionPlanet(
                number: 5,
                planet: planet
            )
        }
    }
    
    func addRandomPisitionPlanet(
        number: Int,
        planet: PlanetsTexturesEnum
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
            
            addPlanet(
                planet: planet,
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
    
    func addPlanet(
        planet: PlanetsTexturesEnum,
        xPos: Float,
        yPos: Float,
        zPos: Float
    ) {
        let sphere = SCNSphere(radius: 0.1)
        let planetNode = SCNNode()
        let zPos: Float = -1.5
        
        planetNode.geometry = sphere
        planetNode.position = SCNVector3(
            xPos,
            yPos,
            zPos
        )
        planetNode.name = planet.rawValue
        
        let material = SCNMaterial()
        material.diffuse.contents = planet.image
        material.locksAmbientWithDiffuse = true
        planetNode.geometry?.materials = [material]
        planetNode.physicsBody = SCNPhysicsBody(
            type: .static,
            shape: nil
        )
        planetNode.physicsBody?.isAffectedByGravity = false
        planetNode.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
        planetNode.physicsBody?.contactTestBitMask = CollisionCategory.missleCategory.rawValue
        
        viewController?.addChild(node: planetNode)
    }
    
    func fire(
        planet: PlanetsTexturesEnum,
        frame: ARFrame
    ) {
        let node = createShot(planet: planet)
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
    
    func createShot(planet: PlanetsTexturesEnum) -> SCNNode {
        let shot = SCNSphere(radius: 0.03)
        let shotNode = SCNNode()
        shotNode.geometry = shot
        shotNode.physicsBody = SCNPhysicsBody(
            type: .dynamic,
            shape: nil
        )
        shotNode.physicsBody?.isAffectedByGravity = false
        
        let material = SCNMaterial()
        material.diffuse.contents = planet.image
        material.locksAmbientWithDiffuse = true
        shotNode.geometry?.materials = [material]
        shotNode.name = planet.rawValue
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
