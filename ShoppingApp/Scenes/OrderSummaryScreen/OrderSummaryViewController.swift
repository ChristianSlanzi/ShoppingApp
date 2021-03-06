//
//  OrderSummaryViewController.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 13.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit
import Overture

final class OrderSummaryViewController: UIViewController {
    
    // MARK: - Viewcontroller Property
    
    var viewModel: OrderSummaryViewModel
    
    // MARK: - FlowDelegate Property
    
    var flowDelegate: ShoppingCartFlowControllerDelegate?
    
    // MARK: - UI Properties
    let tableView = UITableView()
    let orderDeliveryButton = CustomButton()
    
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
        setupViews()
        setupConstraints()
        bind()
        viewModel.viewDidLoad()
    }
    
    // MARK: - Layout Methods
    
    private func setupViews() {
        view.backgroundColor = .systemGray
        title = "ordersummary_screen_title".localized
        
        setupTableView()
        
        with(orderDeliveryButton, concat(autoLayoutStyle, primaryButtonStyle))
        orderDeliveryButton.setTitle("ordersummary_delivery_button".localized)
        
        view.addSubviews(tableView, orderDeliveryButton)
    }
    
    private func setupTableView() {
        //tableView.frame = view.bounds
        //tableView.delegate = self
        
        with(tableView, concat(autoLayoutStyle,
                               mut(\.rowHeight, 80),
                               mut(\.dataSource, self)))
        tableView.removeExcessCells()

        // register cell with tableView
        tableView.register(CartItemSummaryViewCell.self, forCellReuseIdentifier: CartItemSummaryViewCell.reuseID)
    }
    
    // MARK: - MVVM Binding
    
    private func bind() {
        //Input
        orderDeliveryButton.didTouchUpInside = { (sender) in
            self.viewModel.inputs.didTapOrderDeliveryButton()
        }
        
        // Output
        viewModel.outputs.showOrderDeliveryScreen = {
            //guard let self = self else { return }
            self.flowDelegate?.startOrderDelivery()
        }
    }
}

// MARK: - UI Costraints

extension OrderSummaryViewController {
    private func setupConstraints() {
        
        let buttonHeight: CGFloat = .grid_unit(13)
        
        //let topConstraintConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 20 : 80

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: orderDeliveryButton.topAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            orderDeliveryButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            orderDeliveryButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            orderDeliveryButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            orderDeliveryButton.heightAnchor.constraint(equalToConstant: buttonHeight)
        ])
    }
}

// MARK: - Extension (Data Source)

extension OrderSummaryViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //TODO: create a viewModel method to hide details
        viewModel.getElementsCount()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CartItemSummaryViewCell.reuseID, for: indexPath) as! CartItemSummaryViewCell
        cell.set(viewModel: viewModel.getCellViewModel(indexPath))
        return cell
    }
}
