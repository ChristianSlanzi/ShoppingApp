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
    
    var orderId: UILabel!
    var orderDate: UILabel!
    
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
        
        orderId = UILabel()
        orderId.text = "orderinfo_id_placeholder".localized
        
        orderId.backgroundColor = .white
        
        orderDate = UILabel()
        orderDate.text = "orderinfo_date_placeholder".localized
        orderDate.backgroundColor = .white
        

        addToContentView(orderId,
                         orderDate
        )
    }
    
    internal override func setupConstraints() {
        super.setupConstraints()
        
        orderId.translatesAutoresizingMaskIntoConstraints = false
        orderDate.translatesAutoresizingMaskIntoConstraints = false


        let padding: CGFloat = 20
        let labelHeight: CGFloat = 20
        
        let topAnchor = getContentViewTopAnchor()
        let leadingAnchor = getContentViewLeadingAnchor()
        let trailingAnchor = getContentViewTrailingAnchor()
        //let bottomAnchor = getContentViewBottomAnchor()
        
        NSLayoutConstraint.activate([
            orderId.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            orderId.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            orderId.trailingAnchor
                .constraint(equalTo: trailingAnchor, constant: -padding),
            orderId.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            orderDate.topAnchor.constraint(equalTo: orderId.bottomAnchor, constant: padding),
            orderDate.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            orderDate.trailingAnchor
                .constraint(equalTo: trailingAnchor, constant: -padding),
            orderDate.heightAnchor.constraint(equalToConstant: labelHeight)
        ])
        
        setContentViewBottom(view: orderDate)
        
    }
    
    // MARK: - MVVM Binding
    
    private func bind() {
        viewModel.output.id.bind { [weak self] (id) in
            guard let self = self else { return }
            self.orderId.text = id
        }
        viewModel.output.date.bind { [weak self] (date) in
            guard let self = self else { return }
            self.orderDate.text = date
        }
    }
}
