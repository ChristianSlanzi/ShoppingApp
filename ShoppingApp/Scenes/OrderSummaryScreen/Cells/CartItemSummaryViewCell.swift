//
//  CartItemSummaryViewCell.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 14.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit

final class CartItemSummaryViewCell: UITableViewCell {
    
    // MARK: - Viewcontroller Property
    static let reuseID = "CartItemSummaryViewCell"
    
    var viewModel: CartItemSummaryViewModel?
    
    // MARK: - UI Properties
    let productNameLabel = UILabel(frame: .zero)
    let productPriceLabel = UILabel(frame: .zero)
    let quantityLabel = UILabel(frame: .zero)
    let totalPriceLabel = UILabel(frame: .zero)
    
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
     func set(viewModel: CartItemSummaryViewModel?) {
        guard let viewModel = viewModel else { return }
        self.viewModel = viewModel
   
        bind()
     }
    
    private func bind() {
        self.viewModel?.output.name.bind({ (name) in
            self.productNameLabel.text = name
        })
        self.viewModel?.output.price.bind({ (price) in
            self.productPriceLabel.text = price
        })

        self.viewModel?.output.quantity.bind({ (quantity) in
            self.quantityLabel.text = quantity
        })
        
        self.viewModel?.output.total.bind({ (total) in
            self.totalPriceLabel.text = total
        })
    }
    
    private func setupViews() {
        accessoryType = .none
        selectionStyle = .none
        
        totalPriceLabel.textAlignment = .right
        
        addSubviews(productNameLabel,
                    productPriceLabel,
                    quantityLabel,
                    totalPriceLabel)
    }
    
    private func setupConstraints() {
        let padding: CGFloat = 12
        

        productNameLabel.translatesAutoresizingMaskIntoConstraints = false
        productPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        quantityLabel.translatesAutoresizingMaskIntoConstraints = false
        totalPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([

            //TODO: set a proportional width
            productNameLabel.topAnchor.constraint(equalTo: self.topAnchor),
            productNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            productNameLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4),
            productNameLabel.heightAnchor.constraint(equalToConstant: 40),
            
            productPriceLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            productPriceLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            productPriceLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4),
            productPriceLabel.heightAnchor.constraint(equalToConstant: 40),
            
            quantityLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            quantityLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 20),
            //quantityLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.1),
            quantityLabel.heightAnchor.constraint(equalToConstant: 40),
            
            totalPriceLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            totalPriceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            totalPriceLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3),
            totalPriceLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
