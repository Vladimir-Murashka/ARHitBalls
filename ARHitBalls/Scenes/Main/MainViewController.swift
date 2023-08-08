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
    func updateLevelLabel(value: String)
    func updateTimeLabel(value: String)
    func scrollCollectionView(item: Int)
    func updateCollectionView(viewModel: [KitCellViewModel])
    func lockIndicatorRightButton()
    func activeIndicatorRightButton()
    func lockIndicatorLeftButton()
    func activeIndicatorLeftButton()
    func lockStartGameButton()
    func activeStartGameButton()
    func activeDemoGameButton()
    func expand()
}

// MARK: - MainViewController

final class MainViewController: UIViewController {
    var presenter: MainPresenterProtocol?
    
    // MARK: - PrivateProperties
    private var isExpanded: Bool = false
    private var viewModel: [KitCellViewModel] = []
    var homeButtonCenterYConstraint: NSLayoutConstraint!
    var deleteButtonCenterYConstraint: NSLayoutConstraint!
    
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
    
    private lazy var homeButton: UIButton = {
        let button = UIButton(type: .system)
        let imageQuitGameButton = UIImage(named: "homeButton")
        button.setBackgroundImage(
            imageQuitGameButton,
            for: .normal
        )
        button.addTarget(
            self,
            action: #selector(homeButtonPressed),
            for: .touchUpInside
        )
        return button
    }()
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton(type: .system)
        let imageLogoutButton = UIImage(named: "logoutButton")
        button.setBackgroundImage(
            imageLogoutButton,
            for: .normal
        )
        button.addTarget(
            self,
            action: #selector(logoutButtonPressed),
            for: .touchUpInside
        )
        return button
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton(type: .system)
        let imageDeleteAccountButton = UIImage(named: "trashButton")
        button.setBackgroundImage(
            imageDeleteAccountButton,
            for: .normal
        )
        button.addTarget(
            self,
            action: #selector(deleteAccountButtonPressed),
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
        label.text = ""
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
        button.isEnabled = false
        button.addTarget(
            self,
            action: #selector(missionStartGameButtonPressed),
            for: .touchUpInside
        )
        return button
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
        setupViewController()
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
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
    private func homeButtonPressed() {
        homeButton.pushAnimate { [weak self] in
            self?.presenter?.homeButtonPressed()
        }
    }
    
    @objc
    private func logoutButtonPressed() {
        logoutButton.pushAnimate { [weak self] in
            self?.presenter?.logoutButtonPressed()
        }
    }
    
    @objc func deleteAccountButtonPressed() {
        deleteButton.pushAnimate { [weak self] in
            self?.presenter?.deleteAccountButtonPressed()
        }
    }
    
    func expand() {
        if isExpanded {
            UIView.animate(withDuration: 0.5) {
                self.logoutButton.alpha = 0
                self.deleteButton.alpha = 0
                self.homeButtonCenterYConstraint.constant = 0
                self.deleteButtonCenterYConstraint.constant = 0
                self.view.layoutIfNeeded()
                self.homeButton.setBackgroundImage(
                    UIImage(named: "homeButton"),
                    for: .normal
                )
            }
        } else {
            UIView.animate(withDuration: 0.5) {
                self.logoutButton.alpha = 1
                self.deleteButton.alpha = 1
                self.homeButtonCenterYConstraint.constant = (self.homeButton.frame.width + 16)
                self.deleteButtonCenterYConstraint.constant = ((self.homeButton.frame.width + 16) * 2)
                self.view.layoutIfNeeded()
                self.homeButton.setBackgroundImage(
                    UIImage(named: "backButton"),
                    for: .normal
                )
            }
        }
        isExpanded.toggle()
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
}

// MARK: - MainViewProtocol Impl

extension MainViewController: MainViewProtocol {
    func authUser() {
        middleStackView.isHidden = false
        missionStartGameButton.alpha = 1
        missionStartGameButton.isEnabled = true
    }
    
    func updateLevelLabel(value: String) {
        levelLabel.text = value
    }
    
    func updateTimeLabel(value: String) {
        timeLabel.text = value
    }
    
    func scrollCollectionView(item: Int) {
        collectionView.scrollToItem(
            at: IndexPath(item: item, section: 0),
            at: .centeredHorizontally,
            animated: true
        )
    }
    
    func updateCollectionView(viewModel: [KitCellViewModel]) {
        self.viewModel = viewModel
        collectionView.reloadData()
    }
    
    func lockIndicatorRightButton() {
        indicatorRightButton.isEnabled = false
        indicatorRightButton.alpha = 0.5
    }
    
    func activeIndicatorRightButton() {
        indicatorRightButton.isEnabled = true
        indicatorRightButton.alpha = 1
    }
    
    func lockIndicatorLeftButton() {
        indicatorLeftButton.isEnabled = false
        indicatorLeftButton.alpha = 0.5
    }
    
    func activeIndicatorLeftButton() {
        indicatorLeftButton.isEnabled = true
        indicatorLeftButton.alpha = 1
    }
    
    func lockStartGameButton() {
        missionStartGameButton.isEnabled = false
        missionStartGameButton.alpha = 0.5
        startQuickGameButton.isEnabled = false
        startQuickGameButton.alpha = 0.5
    }
    
    func activeStartGameButton() {
        missionStartGameButton.isEnabled = true
        missionStartGameButton.alpha = 1
        startQuickGameButton.isEnabled = true
        startQuickGameButton.alpha = 1
    }
    
    func activeDemoGameButton() {
        startQuickGameButton.isEnabled = true
        startQuickGameButton.alpha = 1
    }
}

// MARK: - PrivateMethods

private extension MainViewController {
    func setupViewController() {
        navigationController?.navigationBar.isHidden = true
        middleStackView.isHidden = true
        lockIndicatorLeftButton()
        addSubViews()
        setupConstraints()
    }
    
    func addSubViews() {
        topStackView.addArrangedSubviews(
            homeButton,
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
            logoutButton,
            deleteButton,
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
        let middleStackViewTopOffset: CGFloat = 22
        let collectionViewSize: CGFloat = 250
        
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
                constant: middleStackViewTopOffset
            ),
            
            collectionStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            collectionView.heightAnchor.constraint(equalToConstant: collectionViewSize),
            collectionView.widthAnchor.constraint(equalToConstant: collectionViewSize),
            
            verticalStackView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -stackViewOffset
            ),
            verticalStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            logoutButton.centerXAnchor.constraint(equalTo: homeButton.centerXAnchor),
            logoutButton.heightAnchor.constraint(equalTo: homeButton.heightAnchor),
            logoutButton.widthAnchor.constraint(equalTo: homeButton.widthAnchor),
            
            deleteButton.centerXAnchor.constraint(equalTo: homeButton.centerXAnchor),
            deleteButton.heightAnchor.constraint(equalTo: homeButton.heightAnchor),
            deleteButton.widthAnchor.constraint(equalTo: homeButton.widthAnchor)
        ])
        
        homeButtonCenterYConstraint = logoutButton.centerYAnchor.constraint(equalTo: homeButton.centerYAnchor)
        homeButtonCenterYConstraint.isActive = true
        
        deleteButtonCenterYConstraint = deleteButton.centerYAnchor.constraint(equalTo: homeButton.centerYAnchor)
        deleteButtonCenterYConstraint.isActive = true
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return viewModel.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.customDequeueReusableCell(
            KitCollectionViewCell.self,
            indexPath: indexPath
        )
        let viewModel = viewModel[indexPath.item]
        cell.configureCell(
            with: viewModel,
            level: indexPath.row
        )
        return cell
    }
}

extension MainViewController: UICollectionViewDelegate {}

extension MainViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView == collectionView,
              let cell = collectionView.visibleCells.first,
              let indexPath = collectionView.indexPath(for: cell)
        else {
            return
        }
        presenter?.didScrollKitCollection(at: indexPath)
    }
}
