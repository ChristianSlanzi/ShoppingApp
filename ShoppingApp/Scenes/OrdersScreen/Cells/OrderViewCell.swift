//
//  OrderViewCell.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 23.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit

final class OrderViewCell: UITableViewCell {
    
    // MARK: - Viewcontroller Property
    static let reuseID = "OrderViewCell"
    
    var viewModel: OrderCellViewModel?
    
    // MARK: - UI Properties
    let orderIdLabel = UILabel(frame: .zero)
    let orderDateLabel = UILabel(frame: .zero)
    
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
     func set(viewModel: OrderCellViewModel?) {
        guard let viewModel = viewModel else { return }
        self.viewModel = viewModel
        bind()
     }
    
    private func bind() {
        self.viewModel?.output.id.bind({ (name) in
            self.orderIdLabel.text = name
        })
        self.viewModel?.output.date.bind({ (date) in
            self.orderDateLabel.text = date
        })
    }
    
    private func setupViews() {
        accessoryType = .none
        selectionStyle = .none
        
        addSubviews(orderIdLabel, orderDateLabel)
    }
    
    private func setupConstraints() {
        let padding: CGFloat = 12
        
        orderIdLabel.translatesAutoresizingMaskIntoConstraints = false
        orderDateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            orderDateLabel.topAnchor.constraint(equalTo: self.topAnchor),
            orderDateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            orderDateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            orderDateLabel.heightAnchor.constraint(equalToConstant: 40),
            
            orderIdLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            orderIdLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            orderIdLabel.heightAnchor.constraint(equalToConstant: 40),
            orderIdLabel.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -padding)
            
        ])
    }
}
