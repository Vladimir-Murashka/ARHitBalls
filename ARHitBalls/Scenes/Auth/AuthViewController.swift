//
//  AuthViewController.swift
//  ARHitBalls
//
//  Created by Swift Learning on 15.08.2022.
//
import UIKit

// MARK: - AuthViewProtocol
protocol AuthViewProtocol: UIViewController {
    
}

// MARK: - AuthViewController
final class AuthViewController: UIViewController {
    var presenter: AuthPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
}

// MARK: - AuthViewProtocol Impl
extension AuthViewController: AuthViewProtocol {
    
}

// MARK: - Private Methods

private extension AuthViewController {
    func setupViewController() {
        addSubViews()
        setupConstraints()
    }
    
    func addSubViews() {
        
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
        ])
    }
    
}
