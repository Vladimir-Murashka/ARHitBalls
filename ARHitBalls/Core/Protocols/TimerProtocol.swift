//
//  TimerProtocol.swift
//  ARHitBalls
//
//  Created by Swift Learning on 26.09.2022.
//

protocol TimerProtocol {
    func transformationTimerLabelText(timeValue: Double) -> String
}

extension TimerProtocol {
    func transformationTimerLabelText(timeValue: Double) -> String {
        let timeStepperValue = Int(timeValue)
        let seconds = timeStepperValue % 60
        let minutes = (timeStepperValue / 60) % 60
        let result = String(
            format: "%02d : %02d",
            minutes,
            seconds
        )
        return result
    }
}
