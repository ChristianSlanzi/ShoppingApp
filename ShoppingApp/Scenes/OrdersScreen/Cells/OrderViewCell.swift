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
    let orderIdIcon = OrderIcon(color: Colors.darkGreen)
    let orderIdLabel = UILabel(frame: .zero)
    let orderDateLabel = UILabel(frame: .zero)
    let orderDateIcon = CalendarIcon()
    
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
        
        orderIdLabel.font = .systemFont(ofSize: 14)
        orderDateLabel.font = .systemFont(ofSize: 14)
        
        addSubviews(orderIdIcon, orderIdLabel, orderDateIcon, orderDateLabel)
    }
    
    private func setupConstraints() {
        let padding: CGFloat = 12
        
        orderIdIcon.translatesAutoresizingMaskIntoConstraints = false
        orderIdLabel.translatesAutoresizingMaskIntoConstraints = false
        orderDateLabel.translatesAutoresizingMaskIntoConstraints = false
        orderDateIcon.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            
            orderIdIcon.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            orderIdIcon.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            orderIdIcon.heightAnchor.constraint(equalToConstant: 20),
            orderIdIcon.widthAnchor.constraint(equalToConstant: 20),
            
            orderIdLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: padding/2),
            orderIdLabel.leadingAnchor.constraint(equalTo: self.orderIdIcon.trailingAnchor, constant: padding),
            orderIdLabel.heightAnchor.constraint(equalToConstant: 32),
            orderIdLabel.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -padding),
            
            orderDateIcon.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding),
            orderDateIcon.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            orderDateIcon.heightAnchor.constraint(equalToConstant: 20),
            orderDateIcon.widthAnchor.constraint(equalToConstant: 20),
            
            orderDateLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding/2),
            orderDateLabel.leadingAnchor.constraint(equalTo: self.orderDateIcon.trailingAnchor, constant: padding),
            orderDateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            orderDateLabel.heightAnchor.constraint(equalToConstant: 32)

        ])
    }
}
