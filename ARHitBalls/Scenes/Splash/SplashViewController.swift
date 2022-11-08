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
        staticDownloadLine()
        animation()
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
    
    func animation() {
        
        let screenSize: CGRect = UIScreen.main.bounds
        
        let width = Int(screenSize.size.width)
        let heigth = Int(screenSize.size.height)
        
        let startXPosition = width / 4
        let finishXPosition = width / 4 * 3
        
        let yPosition = heigth - 200
        
        self.shapeLayer.removeFromSuperlayer()
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: startXPosition, y: yPosition))
        path.addLine(to: CGPoint(x: finishXPosition, y: yPosition))
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = #colorLiteral(red: 0, green: 0.6087715843, blue: 1, alpha: 1).cgColor
        shapeLayer.lineWidth = 6
        shapeLayer.path = path.cgPath
        
        view.layer.addSublayer(shapeLayer)
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.duration = 5
        shapeLayer.add(animation, forKey: "MyAnimation")
        
        self.shapeLayer = shapeLayer
        
    }
    
    func staticDownloadLine() {
        
        let screenSize: CGRect = UIScreen.main.bounds
        
        let width = Int(screenSize.size.width)
        let heigth = Int(screenSize.size.height)
        
        let startXPosition = width / 4
        let finishXPosition = width / 4 * 3
        
        let yPosition = heigth - 200
        
        self.staticShapeLayer.removeFromSuperlayer()
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: startXPosition, y: yPosition))
        path.addLine(to: CGPoint(x: finishXPosition, y: yPosition))
        
        let staticShapeLayer = CAShapeLayer()
        staticShapeLayer.strokeColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        staticShapeLayer.lineWidth = 6
        staticShapeLayer.path = path.cgPath
        
        view.layer.addSublayer(staticShapeLayer)

        self.staticShapeLayer = staticShapeLayer
        
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


