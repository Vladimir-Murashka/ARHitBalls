//
//  GamePresenter.swift
//  ARHitBalls
//
//  Created by Swift Learning on 15.08.2022.
//

import UIKit

// MARK: - GamePresenterProtocol

protocol GamePresenterProtocol: AnyObject {
    func viewDidLoad()
    func quitGameButtonPressed()
    func shotButtonPressed(tag: Int)
}

// MARK: - GamePresenter

final class GamePresenter {
    weak var viewController: GameViewProtocol?
    
    // MARK: - PrivateProperties
    
    private let sceneBuildManager: Buildable
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
    func transformationTimerLabelText(timeValue: Double) -> String {
        let timeStepperValue = Int(timeValue)
        let seconds = timeStepperValue % 60
        let minutes = (timeStepperValue / 60) % 60
        let result = String(
            format: "%02d:%02d",
            minutes,
            seconds
        )
        return result
    }
}
