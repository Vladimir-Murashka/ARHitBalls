//
//  GamePresenter.swift
//  ARHitBalls
//
//  Created by Swift Learning on 15.08.2022.
//

import ARKit
import UIKit

// MARK: - GamePresenterProtocol

protocol GamePresenterProtocol: AnyObject {
    func viewDidLoad()
    func viewWillAppear()
    func viewWillDisappear()
    func quitGameButtonPressed()
    func shotButtonPressed(tag: Int)
}

// MARK: - GamePresenter

final class GamePresenter {
    weak var viewController: GameViewProtocol?
    
    // MARK: - PrivateProperties
    
    private let sceneBuildManager: Buildable
    
    // MARK: - Initializer
    
    init(sceneBuildManager: Buildable) {
        self.sceneBuildManager = sceneBuildManager
    }
}

//MARK: - GamePresenterExtension

extension GamePresenter: GamePresenterProtocol {
    func viewDidLoad() {
        addPlanets()
    }
    
    func viewWillAppear() {
        let configuration = ARWorldTrackingConfiguration()
        viewController?.sessionRun(with: configuration)
    }
    
    func viewWillDisappear() {
        viewController?.sessionPause()
    }
    
    func quitGameButtonPressed() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
    func shotButtonPressed(tag: Int) {
        switch tag {
        case 0:
            break
        case 1:
            break
        case 2:
            break
        case 3:
            break
        case 4:
            break
        case 5:
            break
        default:
            break
        }
    }
}

private extension GamePresenter {
    func addPlanets() {
        let planets = Planet.allCases
        for planet in planets {
            addRandomPisitionPlanet(
                number: 5,
                planet: planet
            )
        }
    }
    
    private func addRandomPisitionPlanet(
        number: Int,
        planet: Planet
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
    
    private func randomPosition(
        from: Float,
        to: Float
    ) -> Float {
        return Float(arc4random()) / Float(UInt32.max) * (from - to) + to
    }
    
    private func addPlanet(
        planet: Planet,
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
}
