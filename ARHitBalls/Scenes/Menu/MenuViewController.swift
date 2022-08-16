//
//  MenuViewController.swift
//  ARHitBalls
//
//  Created by Swift Learning on 15.08.2022.
//

import UIKit

// MARK: - MenuViewProtocol
protocol MenuViewProtocol: UIViewController {
    
}

// MARK: - MenuViewController
final class MenuViewController: UIViewController {
    var presenter: MenuPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
}

// MARK: - MenuViewProtocol Impl
extension MenuViewController: MenuViewProtocol {
    
}

// MARK: - Private Methods

private extension MenuViewController {
    func setupViewController() {
        view.backgroundColor = .yellow
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
