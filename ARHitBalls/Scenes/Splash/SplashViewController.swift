//
//  SplashViewController.swift
//  ARHitBalls
//
//  Created by Swift Learning on 15.08.2022.
//

import UIKit

// MARK: - SplashViewProtocol

protocol SplashViewProtocol: UIViewController {}

// MARK: - SplashViewController

final class SplashViewController: UIViewController {
    var presenter: SplashPresenterProtocol?
    
    // MARK: - PrivateProperties
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "bell")
        return imageView
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        presenter?.viewDidLoad()
    }
}

// MARK: - SplashViewProtocol Impl

extension SplashViewController: SplashViewProtocol {}

// MARK: - PrivateMethods

private extension SplashViewController {
    func setupViewController() {
        addSubViews()
        setupConstraints()
    }
    
    func addSubViews() {
        view.addSubviews(imageView)
    }
    
    func setupConstraints() {
        let imageViewSize: CGFloat = 200
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: imageViewSize),
            imageView.widthAnchor.constraint(equalToConstant: imageViewSize)
        ])
    }
}


