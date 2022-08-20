//
//  SettingsViewController.swift
//  ARHitBalls
//
//  Created by Swift Learning on 15.08.2022.
//
import UIKit

// MARK: - SettingsViewProtocol

protocol SettingsViewProtocol: UIViewController {}

// MARK: - SettingsViewController

final class SettingsViewController: UIViewController {
    var presenter: SettingsPresenterProtocol?
    
//MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
}

// MARK: - SettingsViewProtocol Impl

extension SettingsViewController: SettingsViewProtocol {}

// MARK: - Private Methods

private extension SettingsViewController {
    func setupViewController() {
        addSubViews()
        setupConstraints()
    }
    
    func addSubViews() {}
    
    func setupConstraints() {
        NSLayoutConstraint.activate([])
    }
}
