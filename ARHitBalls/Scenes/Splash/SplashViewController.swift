//
//  SplashViewController.swift
//  ARHitBalls
//
//  Created by Swift Learning on 15.08.2022.
//

import UIKit

// MARK: - SplashViewProtocol
protocol SplashViewProtocol: UIViewController {
    
}

// MARK: - SplashViewController
final class SplashViewController: UIViewController {
    var presenter: SplashPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
    }
}

// MARK: - SplashViewProtocol Impl
extension SplashViewController: SplashViewProtocol {
    
}


