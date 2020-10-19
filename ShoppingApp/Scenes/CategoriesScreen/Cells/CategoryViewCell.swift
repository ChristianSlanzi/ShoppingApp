//
//  CategoryViewCell.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 08.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit
import CS_Common_Utils
import Overture

final class CategoryViewCell: UICollectionViewCell {
    
    // MARK: - Properties

    static let reuseID = "CategoryViewCell"
    
    let nameLabel = UILabel(frame: .zero)
    lazy var nameLabelWrapper: UIView = wrapView(padding: UIEdgeInsets.init(top: .grid_unit(1), left: .grid_unit(2), bottom: .grid_unit(1), right: .grid_unit(2)))(self.nameLabel)
    
    let descriptionLabel = UILabel(frame: .zero)
    lazy var descriptionLabelWrapper: UIView = wrapView(padding: UIEdgeInsets.init(top: .grid_unit(1), left: .grid_unit(2), bottom: .grid_unit(1), right: .grid_unit(2)))(self.descriptionLabel)
    
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
    
    func set(viewModel: Category) { //TODO: a cell viewModel
        nameLabel.text = viewModel.name
        descriptionLabel.text = viewModel.description
        imageView.image = UIImage(named: viewModel.imageUrl)
    }
    
    // MARK: - Layout Methods

    private func setupViews() {
        
        with( self,
            concat(
                autoLayoutStyle,
                baseRoundedStyle,
                mut(\.backgroundColor, .lightGray)
        ))
        
        nameLabel.text = "categories_category_placeholder".localized
        
        with(self.nameLabel, concat(
            smallCapsLabelStyle,
            mut(\.textColor, .white)
        ))
        
        with( nameLabelWrapper,
            concat(
                autoLayoutStyle,
                baseRoundedStyle,
                mut(\UIView.backgroundColor, UIColor.init(white: 0, alpha: 0.3))
        ))
        
        descriptionLabel.text = "categories_description_placeholder".localized
        
        with(self.descriptionLabel, concat(
            mut(\.textColor, .white)
        ))
        
        with( descriptionLabelWrapper,
            concat(
                autoLayoutStyle,
                baseRoundedStyle,
                mut(\UIView.backgroundColor, UIColor.init(white: 0, alpha: 0.3))
        ))
        
        with( imageView,
            concat(
                autoLayoutStyle,
                baseRoundedStyle,
                mut(\.backgroundColor, .lightGray),
                mut(\.contentMode, .scaleAspectFill)
        ))
        
        addSubviews(imageView, nameLabelWrapper, descriptionLabelWrapper)
    }
    
    private func setupConstraints() {
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
            nameLabelWrapper.topAnchor.constraint(equalTo: contentView.topAnchor, constant: vPadding),
            nameLabelWrapper.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: hPadding),
            nameLabelWrapper.heightAnchor.constraint(equalToConstant: labelHeight)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabelWrapper.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -vPadding),
            descriptionLabelWrapper.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: hPadding),
            descriptionLabelWrapper.heightAnchor.constraint(equalToConstant: labelHeight)
        ])
    }
}
