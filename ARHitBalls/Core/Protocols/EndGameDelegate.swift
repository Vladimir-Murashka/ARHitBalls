//
//  EndGameDelegateProtocol.swift
//  ARHitBalls
//
//  Created by Swift Learning on 30.11.2022.
//

protocol EndGameDelegate: AnyObject {
    func continueGame()
    func exitGame()
    func restartLevel()
    func nextLevel()
    func newGameValue() -> [String]
    func logout()
    func deleteAccount()
}
