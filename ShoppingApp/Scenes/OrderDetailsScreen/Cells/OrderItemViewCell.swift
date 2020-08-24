//
//  OrderItemViewCell.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 12.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit

final class OrderItemViewCell: UITableViewCell {
    
    // MARK: - Viewcontroller Property
    static let reuseID = "OrderItemViewCell"
    
    var viewModel: OrderItemCellViewModel?
    
    // MARK: - UI Properties
    let productImageView = UIImageView(frame: .zero)
    let productNameLabel = UILabel(frame: .zero)
    
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
        self.viewModel?.output.name.bind({ (name) in
            self.productNameLabel.text = name
        })
        self.viewModel?.output.imageUrl.bind({ (url) in
            self.productImageView.image = UIImage(named: url)
        })
    }
    
    private func setupViews() {
        accessoryType = .none
        selectionStyle = .none
        
        productImageView.backgroundColor = .lightGray
        productImageView |> roundedStyle
        
        addSubviews(productImageView, productNameLabel)
    }
    
    private func setupConstraints() {
        let padding: CGFloat = 12
        
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        productNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            productImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            productImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            productImageView.heightAnchor.constraint(equalToConstant: 60),
            productImageView.widthAnchor.constraint(equalToConstant: 60),
            
            productNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            productNameLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 24),
            productNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            productNameLabel.heightAnchor.constraint(equalToConstant: 40),
            
        ])
    }
}