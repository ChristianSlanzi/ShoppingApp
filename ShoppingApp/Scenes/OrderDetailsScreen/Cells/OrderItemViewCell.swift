//
//  OrderItemViewCell.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 12.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit
import CS_Common_Utils
import Overture

final class OrderItemViewCell: UITableViewCell {
    
    // MARK: - Viewcontroller Property
    static let reuseID = "OrderItemViewCell"
    
    var viewModel: OrderItemCellViewModel?
    
    // MARK: - UI Properties
    let productImageView = UIImageView(frame: .zero)
    let productNameLabel = UILabel(frame: .zero)
    let productPriceLabel = UILabel(frame: .zero)
    let productQuantityLabel = UILabel(frame: .zero)
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
        bind()
    }
    
    /// init required by the API to support storyboards
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout Methods
    
    /// call from cellForRowAtIndexPath to set this cell's properties
     func set(viewModel: OrderItemCellViewModel?) {
        guard let viewModel = viewModel else { return }
        self.viewModel = viewModel

        bind()
     }
    
    private func bind() {
        self.viewModel?.output.imageUrl.bind({ (url) in
            self.productImageView.image = UIImage(named: url)
        })
        self.viewModel?.output.name.bind({ (name) in
            self.productNameLabel.text = name
        })
        self.viewModel?.output.price.bind({ (price) in
            self.productPriceLabel.text = price
        })
        self.viewModel?.output.quantity.bind({ (quantity) in
            self.productQuantityLabel.text = quantity
        })
    }
    
    private func setupViews() {
        accessoryType = .none
        selectionStyle = .none
        
        with( productNameLabel, concat( autoLayoutStyle ))
        productNameLabel.font = .systemFont(ofSize: 14)
        
        with( productPriceLabel, concat( autoLayoutStyle ))
        productPriceLabel.font = .systemFont(ofSize: 14)
        
        with( productQuantityLabel, concat( autoLayoutStyle ))
        productQuantityLabel.font = .systemFont(ofSize: 14)

        with( productImageView,
            concat(
                autoLayoutStyle,
                baseRoundedStyle,
                mut(\.backgroundColor, .lightGray)
        ))
        
        addSubviews(productImageView, productNameLabel, productPriceLabel, productQuantityLabel)
    }
    
    private func setupConstraints() {
        let padding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            productImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            productImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            productImageView.heightAnchor.constraint(equalToConstant: 60),
            productImageView.widthAnchor.constraint(equalToConstant: 60),
            
            productNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            productNameLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 24),
            productNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            productNameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            productPriceLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding),
            productPriceLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 24),
            productPriceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            productPriceLabel.heightAnchor.constraint(equalToConstant: 20),
            
            productQuantityLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            productQuantityLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding*2),
            productQuantityLabel.heightAnchor.constraint(equalToConstant: 40),
            
        ])
    }
}
