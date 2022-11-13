//
//  MainViewController.swift
//  ARHitBalls
//
//  Created by Swift Learning on 15.08.2022.
//

import UIKit

// MARK: - MainViewProtocol

protocol MainViewProtocol: UIViewController {
    func authUser()
}

// MARK: - MainViewController

final class MainViewController: UIViewController {
    var presenter: MainPresenterProtocol?
    
    // MARK: - PrivateProperties
    
    private var kitCollections: [KitCellViewModel] = [
        KitCellViewModel.init(image: "planetCollection"),
        KitCellViewModel.init(image: "fruitCollection"),
        KitCellViewModel.init(image: "billiardCollection"),
        KitCellViewModel.init(image: "ballCollection")
    ]
    
    private let imageViewBackgroundScreen: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "generalBackground")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "LogoS")
        return imageView
    }()
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton(type: .system)
        let imageQuitGameButton = UIImage(named: "homeButton")
        button.setBackgroundImage(
            imageQuitGameButton,
            for: .normal
        )
        button.addTarget(
            self,
            action: #selector(logoutButtonPressed),
            for: .touchUpInside
        )
        return button
    }()
    
    private lazy var settingsButton: UIButton = {
        let button = UIButton(type: .system)
        let imageSettingGameButton = UIImage(named: "settingButton")
        button.setBackgroundImage(
            imageSettingGameButton,
            for: .normal
        )
        button.addTarget(
            self,
            action: #selector(settingsButtonPressed),
            for: .touchUpInside
        )
        return button
    }()
    
    private let topStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        return stackView
    }()
    
    private let timeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "timeImage")
        return imageView
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(
            name: "Dela Gothic One",
            size: 24
        ) ?? .systemFont(ofSize: 24)
        label.text = "00:20"
        return label
    }()
    
    private let timeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 2
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private let levelImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "levelImage")
        return imageView
    }()
    
    private let levelLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(
            name: "Dela Gothic One",
            size: 24
        ) ?? .systemFont(ofSize: 24)
        label.text = "5"
        return label
    }()
    
    private let levelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 2
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private let middleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 50
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        return stackView
    }()
    
    private lazy var indicatorLeftButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(
            UIImage(named: "indicatorLeft"),
            for: .normal
        )
        button.addTarget(
            self,
            action: #selector(indicatorLeftButtonPressed),
            for: .touchUpInside
        )
        return button
    }()
    
    private lazy var indicatorRightButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(
            UIImage(named: "indicatorRight"),
            for: .normal
        )
        button.addTarget(
            self,
            action: #selector(indicatorRightButtonPressed),
            for: .touchUpInside
        )
        return button
    }()
    
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: KitCollectionViewFlowLayout(itemSize: KitCollectionViewCell.cellSize)
        )
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.customRegister(KitCollectionViewCell.self)
        return collectionView
    }()
    
    private let collectionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 0
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        return stackView
    }()
    
    private lazy var startQuickGameButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(
            UIImage(named: "demoButtonMain"),
            for: .normal
        )
        button.addTarget(
            self,
            action: #selector(startQuickGameButtonPressed),
            for: .touchUpInside
        )
        return button
    }()
    
    private lazy var missionStartGameButton: StartButton = {
        let button = StartButton(type: .system)
        button.alpha = 0.5
        button.setBackgroundImage(
            UIImage(named: "srartMissionGame"),
            for: .normal
        )
        button.addTarget(
            self,
            action: #selector(missionStartGameButtonPressed),
            for: .touchUpInside
        )
        return button
    }()
    
    private let kitStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 5
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        return stackView
    }()
    
    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 12
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        stackView.axis = .vertical
        return stackView
    }()
    
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setupViewController()
    }
    
    // MARK: - Actions
    
    @objc
    private func settingsButtonPressed() {
        settingsButton.pushAnimate { [weak self] in
            self?.presenter?.settingsButtonPressed()
        }
    }
    
    @objc
    private func startQuickGameButtonPressed() {
        startQuickGameButton.pushAnimate { [weak self] in
            self?.presenter?.startQuickGameButtonPressed()
        }
    }
    
    @objc
    private func logoutButtonPressed() {
        logoutButton.pushAnimate { [weak self] in
            self?.presenter?.logoutButtonPressed()
        }
    }
    
    @objc
    private func missionStartGameButtonPressed() {
        missionStartGameButton.pushAnimate { [weak self] in
            self?.presenter?.missionStartGameButtonPressed()
        }
    }
    
    @objc
    private func indicatorLeftButtonPressed() {
        indicatorLeftButton.pushAnimate { [weak self] in
            self?.presenter?.indicatorLeftButtonPressed()
        }
    }
    
    @objc
    private func indicatorRightButtonPressed() {
        indicatorRightButton.pushAnimate { [weak self] in
            self?.presenter?.indicatorRightButtonPressed()
        }
    }
    
    @objc
    private func kitButtonsPressed(sender: UIButton) {
        kitStackView.subviews.forEach {
            $0.alpha = sender == $0 ? 1 : 0.5
        }
        presenter?.kitButtonsPressed(tag: sender.tag)
    }
}

// MARK: - MainViewProtocol Impl

extension MainViewController: MainViewProtocol {
    func authUser() {
        missionStartGameButton.alpha = 1
    }
}

// MARK: - PrivateMethods

private extension MainViewController {
    func setupViewController() {
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .systemGray
        addSubViews()
        setupKitButtons()
        setupConstraints()
    }
    
    func setupKitButtons() {
        let kitButtons = KitEnum.allCases
        
        kitButtons.enumerated().forEach { index, kit in
            let button = ShotButton()
            button.setupBackgroundImage(named: kit.imageName )
            button.addTarget(
                self,
                action: #selector(kitButtonsPressed),
                for: .touchUpInside
            )
            button.tag = index
            if button.tag == 0 {
                button.alpha = 1
            }
            kitStackView.addArrangedSubview(button)
        }
    }
    
    func addSubViews() {
        topStackView.addArrangedSubviews(
            logoutButton,
            settingsButton
        )
        
        timeStackView.addArrangedSubviews(
            timeImageView,
            timeLabel
        )
        
        levelStackView.addArrangedSubviews(
            levelImageView,
            levelLabel
        )
        
        middleStackView.addArrangedSubviews(
            timeStackView,
            levelStackView
        )
        
        collectionStackView.addArrangedSubviews(
            indicatorLeftButton,
            collectionView,
            indicatorRightButton
        )
        
        verticalStackView.addArrangedSubviews(
            missionStartGameButton,
            startQuickGameButton
        )
        
        view.addSubviews(
            imageViewBackgroundScreen,
            logoImageView,
            topStackView,
            middleStackView,
            collectionStackView,
            verticalStackView
        )
    }
    
    func setupConstraints() {
        let imageViewBackgroundScreenIndent: CGFloat = 0
        let logoImageViewTopIndent: CGFloat = 52
        let stackViewOffset: CGFloat = 16
        
        NSLayoutConstraint.activate([
            imageViewBackgroundScreen.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: imageViewBackgroundScreenIndent
            ),
            imageViewBackgroundScreen.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: imageViewBackgroundScreenIndent
            ),
            imageViewBackgroundScreen.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: imageViewBackgroundScreenIndent
            ),
            imageViewBackgroundScreen.bottomAnchor.constraint(
                equalTo: view.bottomAnchor,
                constant: imageViewBackgroundScreenIndent
            ),
            
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: logoImageViewTopIndent
            ),
            
            topStackView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: stackViewOffset
            ),
            topStackView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: stackViewOffset
            ),
            topStackView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -stackViewOffset
            ),
            
            middleStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            middleStackView.topAnchor.constraint(
                equalTo: logoImageView.bottomAnchor,
                constant: 22
            ),
            
            collectionStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            collectionView.heightAnchor.constraint(equalToConstant: 250),
            collectionView.widthAnchor.constraint(equalToConstant: 240),
            
            verticalStackView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -stackViewOffset
            ),
            verticalStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return kitCollections.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.customDequeueReusableCell(
            KitCollectionViewCell.self,
            indexPath: indexPath
        )
        let viewModel = kitCollections[indexPath.item]
        cell.configureCell(with: viewModel)
        return cell
    }
}

extension MainViewController: UICollectionViewDelegate {}
