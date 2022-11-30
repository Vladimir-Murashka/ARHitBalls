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
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - PublicMethods
    
    func configureCell(with viewModel: KitCellViewModel) {
        collectionImageView.image = UIImage(named: viewModel.image)
        collectionLockImageView.isHidden = viewModel.isLocked ? true : false
        collectionImageView.alpha = viewModel.isLocked ? 1 : 0.5
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
        contentView.addSubviews(collectionLockImageView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            collectionImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
            collectionLockImageView.topAnchor.constraint(equalTo: collectionImageView.topAnchor, constant: 90),
            collectionLockImageView.centerXAnchor.constraint(equalTo: collectionImageView.centerXAnchor)
        ])
    }
}
