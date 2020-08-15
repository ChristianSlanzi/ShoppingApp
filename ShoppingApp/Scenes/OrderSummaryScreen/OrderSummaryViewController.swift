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
    let orderButton = CustomButton()
    
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
        
        setupTableView()
        
        orderButton.set(backgroundColor: .systemGreen, title: "Order now")
        orderButton.addTarget(self, action: #selector(didTapOrderButton), for: .touchUpInside)
        
        view.addSubviews(tableView, orderButton)
    }
    
    private func setupTableView() {
        //tableView.frame = view.bounds
        tableView.rowHeight = 80
        //tableView.delegate = self
        tableView.dataSource = self
        tableView.removeExcessCells()

        // register cell with tableView
        tableView.register(CartItemSummaryViewCell.self, forCellReuseIdentifier: CartItemSummaryViewCell.reuseID)
    }
    
    // MARK: - MVVM Binding
    
    private func bind() {

    }
    
    @objc private func didTapOrderButton(_ sender: Any) {
        //viewModel.inputs.didTapOrderButton()
    }
}

// MARK: - UI Costraints

extension OrderSummaryViewController {
    private func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        orderButton.translatesAutoresizingMaskIntoConstraints = false
        
        //let topConstraintConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 20 : 80

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: orderButton.topAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            orderButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            orderButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            orderButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            orderButton.heightAnchor.constraint(equalToConstant: 50)
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
