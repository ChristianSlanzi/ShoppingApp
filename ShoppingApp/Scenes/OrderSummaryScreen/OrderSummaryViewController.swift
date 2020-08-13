//
//  OrderSummaryViewController.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 13.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit

final class OrderSummaryViewController: UIViewController {
    
    // MARK: - Viewcontroller Property
    
    var viewModel: OrderSummaryViewModel
    
    // MARK: - FlowDelegate Property
    
    var flowDelegate: ShoppingCartFlowControllerDelegate?
    
    // MARK: - UI Properties
    let tableView = UITableView()
    
    // MARK: - Viewcontroller Lifecycle
    
    init(viewModel: OrderSummaryViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        setupViews()
        setupConstraints()
        bind()
    }
    
    // MARK: - Layout Methods
    
    private func setupViews() {
        view.backgroundColor = .systemGray
        title = "Order Summary"

    }
    
    // MARK: - MVVM Binding
    
    private func bind() {

    }
}

// MARK: - UI Costraints

extension OrderSummaryViewController {
    private func setupConstraints() {

    }
}
