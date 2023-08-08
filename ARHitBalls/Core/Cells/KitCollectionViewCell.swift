//
//  KitCollectionViewCell.swift
//  ARHitBalls
//
//  Created by Swift Learning on 13.11.2022.
//

import UIKit

final class KitCollectionViewCell: UICollectionViewCell {
    
    static let cellSize = CGSize(
        width: 250,
        height: 250
    )
    
    // MARK: - PrivateProperties
    
    private let collectionImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let collectionLockImageView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "CollectionLock")
        imageView.image = image
        return imageView
    }()
    
    private let collectionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = .zero
        label.textAlignment = .center
        return label
    }()
    
    private let collectionLockStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        return stackView
    }()
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - PublicMethods
    
    func configureCell(
        with viewModel: KitCellViewModel,
        level: Int
    ) {
        collectionImageView.image = UIImage(named: viewModel.image)
        collectionLockStackView.isHidden = viewModel.isLocked ? true : false
        collectionImageView.alpha = viewModel.isLocked ? 1 : 0.5
        collectionLabel.text = "Для открытия этого контента необхожимо пройти \(level * 10) уровней"
    }
}

// MARK: - PrivateMethods

private extension KitCollectionViewCell {
    func setupCell() {
        setupContentView()
        addSubViews()
        setupConstraints()
    }
    
    func setupContentView() {
        backgroundColor = .clear
    }
    
    func addSubViews() {
        contentView.addSubviews(collectionImageView)
        collectionLockStackView.addArrangedSubviews(collectionLockImageView,
                                                    collectionLabel)
        contentView.addSubviews(collectionLockStackView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            collectionImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
            collectionLockStackView.topAnchor.constraint(equalTo: collectionImageView.topAnchor, constant: 68),
            collectionLockStackView.leadingAnchor.constraint(equalTo: collectionImageView.leadingAnchor, constant: 16),
            collectionLockStackView.trailingAnchor.constraint(equalTo: collectionImageView.trailingAnchor, constant: -16)
        ])
    }
}
