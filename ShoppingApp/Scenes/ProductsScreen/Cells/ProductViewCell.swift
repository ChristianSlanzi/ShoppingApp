//
//  ProductViewCell.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 08.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit

final class ProductViewCell: UICollectionViewCell {
    // MARK: - Properties

    static let reuseID = "ProductViewCell"
    
    let nameLabel = UILabel(frame: .zero)
    let descriptionLabel = UILabel(frame: .zero)

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
    }
    
    // MARK: - Layout Methods

    private func setupViews() {
        self |> roundedStyle
        backgroundColor = .lightGray //.systemBackground
        addSubviews(nameLabel, descriptionLabel)
        nameLabel.text = "product"
        descriptionLabel.text = "product description"
    }
    
    private func setupConstraints() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false

        let padding: CGFloat = 8

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            nameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
