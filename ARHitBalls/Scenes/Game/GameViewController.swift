//
//  GameViewController.swift
//  ARHitBalls
//
//  Created by Swift Learning on 15.08.2022.
//
import UIKit

// MARK: - GameViewProtocol

protocol GameViewProtocol: UIViewController {}

// MARK: - GameViewController

final class GameViewController: UIViewController {
    var presenter: GamePresenterProtocol?
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
}

// MARK: - GameViewProtocol Impl

extension GameViewController: GameViewProtocol {}

// MARK: - PrivateMethods

private extension GameViewController {
    func setupViewController() {
        addSubViews()
        setupConstraints()
    }
    
    func addSubViews() {}
    
    func setupConstraints() {
        NSLayoutConstraint.activate([])
    }
}
