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
    }
}

// MARK: - MenuViewProtocol Impl
extension MenuViewController: MenuViewProtocol {
    
}
