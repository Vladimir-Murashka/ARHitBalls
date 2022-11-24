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
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "splashScreenBackground")
        imageView.applyBlurEffect()
        return imageView
    }()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "LogoB")
        return imageView
    }()
    
    private let progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.backgroundColor = .white
        progressView.progressTintColor = #colorLiteral(red: 0.1176470588, green: 0.2039215686, blue: 0.4901960784, alpha: 1)
        progressView.layer.cornerRadius = 4
        progressView.clipsToBounds = true
        return progressView
    }()
    
    private var shapeLayer = CAShapeLayer()
    private var staticShapeLayer = CAShapeLayer()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        presenter?.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(
            withDuration: 5,
            delay: 0
        ) {
            self.progressView.setProgress(
                1,
                animated: true
            )
        }
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
        view.addSubviews(
            backgroundImageView,
            progressView,
            logoImageView
        )
    }
    
    func setupConstraints() {
        let sideOfSet: CGFloat = view.bounds.width / 4
        let logoTopOfSet: CGFloat = 250
        let logoWidth: CGFloat = 217
        let progressViewBottomOfSet: CGFloat = 200
        let progressViewHeight: CGFloat = 7
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: logoTopOfSet
            ),
            logoImageView.widthAnchor.constraint(equalToConstant: logoWidth),
            
            progressView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: sideOfSet
            ),
            progressView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -sideOfSet
            ),
            progressView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -progressViewBottomOfSet
            ),
            progressView.heightAnchor.constraint(equalToConstant: progressViewHeight)
        ])
    }
}
