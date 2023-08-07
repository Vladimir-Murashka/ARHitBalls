//
//  CustomPopUpDelegateProtocol.swift
//  ARHitBalls
//
//  Created by Swift Learning on 30.11.2022.
//

import Foundation

@objc protocol CustomPopUpDelegate: AnyObject {
    @objc optional func continueGame()
    @objc optional func exitGame()
    @objc optional func restartLevel()
    @objc optional func nextLevel()
    @objc optional func newGameValue() -> [String]
    @objc optional func logout()
    @objc optional func deleteAccount()
}
