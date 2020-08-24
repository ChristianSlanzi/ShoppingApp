//
//  OrderDetailsViewController.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 24.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit

final class OrderDetailsViewController: CustomScrollViewController {
    
    // MARK: - Viewcontroller Property
    
    var viewModel: OrderDetailsViewModel
    
    // MARK: - FlowDelegate Property
    
    var flowDelegate: OrderFlowControllerDelegate?
    
    // MARK: - UI Properties
    
    var orderImage: UIImageView!
    var orderName: UILabel!
    var orderPrice: UILabel!
    var orderDescription: UILabel!
    
    // MARK: - Viewcontroller Lifecycle
    
    init(viewModel: OrderDetailsViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        bind()
        viewModel.viewDidLoad()
    }
    
    // MARK: - Layout Methods
    
    internal override func setupViews() {
        super.setupViews()
        view.backgroundColor = .systemBackground
        title = "orderinfo_screen_title".localized
        
        orderImage = UIImageView()
        orderImage |> roundedStyle
        orderImage.backgroundColor = .lightGray
        
        orderName = UILabel()
        orderName.text = "orderinfo_order_placeholder".localized
        
        orderName.backgroundColor = .white
        
        orderPrice = UILabel()
        orderPrice.text = "orderinfo_price_placeholder".localized
        orderPrice.backgroundColor = .white
        
        orderDescription = UILabel()
        orderDescription.numberOfLines = 0
        orderDescription.text = "orderinfo_description_placeholder".localized
        orderDescription.backgroundColor = .white
        

        addToContentView(orderImage,
                         orderName,
                         orderPrice,
                         orderDescription
        )
    }
    
    internal override func setupConstraints() {
        super.setupConstraints()
        
        orderImage.translatesAutoresizingMaskIntoConstraints = false
        orderName.translatesAutoresizingMaskIntoConstraints = false
        orderPrice.translatesAutoresizingMaskIntoConstraints = false
        orderDescription.translatesAutoresizingMaskIntoConstraints = false

        
        let topAnchor = getContentViewTopAnchor()
        let leadingAnchor = getContentViewLeadingAnchor()
        let trailingAnchor = getContentViewTrailingAnchor()
        //let bottomAnchor = getContentViewBottomAnchor()
        
        NSLayoutConstraint.activate([
            orderImage.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            orderImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            orderImage.trailingAnchor
                .constraint(equalTo: trailingAnchor, constant: -20),
            orderImage.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            orderName.topAnchor.constraint(equalTo: orderImage.bottomAnchor, constant: 20),
            orderName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            orderName.trailingAnchor
                .constraint(equalTo: trailingAnchor, constant: -20),
            orderName.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            orderPrice.topAnchor.constraint(equalTo: orderName.bottomAnchor, constant: 20),
            orderPrice.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            orderPrice.trailingAnchor
                .constraint(equalTo: trailingAnchor, constant: -20),
            orderPrice.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            orderDescription.topAnchor.constraint(equalTo: orderPrice.bottomAnchor, constant: 20),
            orderDescription.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            orderDescription.trailingAnchor
                .constraint(equalTo: trailingAnchor, constant: -20),
            orderDescription.heightAnchor.constraint(greaterThanOrEqualToConstant: 30)
        ])
        
        setContentViewBottom(view: orderDescription)
        
    }
    
    // MARK: - MVVM Binding
    
    private func bind() {
        viewModel.output.id.bind { [weak self] (name) in
            guard let self = self else { return }
            self.orderName.text = name
        }

    }
}
