//
//  ProductViewCell.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 08.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit
import Utils

final class ProductViewCell: UICollectionViewCell {
    // MARK: - Properties

    static let reuseID = "ProductViewCell"
    
    let nameLabel = UILabel(frame: .zero)
    let descriptionLabel = UILabel(frame: .zero)
    let imageView = UIImageView(frame: .zero)

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }

    /// init required by the API to support storyboards
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(viewModel: Product) { //TODO: a cell viewModel
        nameLabel.text = viewModel.name
        descriptionLabel.text = viewModel.description
        imageView.image = UIImage(named: viewModel.imageUrl)
    }
    
    // MARK: - Layout Methods

    private func setupViews() {
        self |> roundedStyle
        backgroundColor = .lightGray //.systemBackground
        addSubviews(imageView, nameLabel, descriptionLabel)
        
        nameLabel.text = "products_product_placeholder".localized
        nameLabel.textColor = .white
        
        descriptionLabel.text = "products_description_placeholder".localized
        descriptionLabel.textColor = .white
        
        imageView.backgroundColor = .lightGray
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
    }
    
    private func setupConstraints() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false

        let vPadding: CGFloat = .grid_unit(3)
        let hPadding: CGFloat = .grid_unit(2)
        let labelHeight: CGFloat = .grid_unit(6)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: vPadding),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: hPadding),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -hPadding),
            nameLabel.heightAnchor.constraint(equalToConstant: labelHeight)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -vPadding),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: hPadding),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -hPadding),
            descriptionLabel.heightAnchor.constraint(equalToConstant: labelHeight)
        ])
    }
}
