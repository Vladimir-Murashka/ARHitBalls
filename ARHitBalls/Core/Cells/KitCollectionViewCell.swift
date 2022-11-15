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
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            collectionImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
        ])
    }
}
