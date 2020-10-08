//
//  OrdersViewController.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 23.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit
import Overture

final class OrdersViewController: UIViewController {
    
    // MARK: - Viewcontroller Property
    
    var viewModel: OrdersViewModel
    
    // MARK: - FlowDelegate Property
    
    var flowDelegate: OrderFlowControllerDelegate?
    
    // MARK: - UI Properties
    let tableView = UITableView()
    
    // MARK: - Viewcontroller Lifecycle
    
    init(viewModel: OrdersViewModel) {
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
        title = "orders_list_screen_title".localized
        setupTableView()
        view.addSubviews(tableView)
    }
    
    private func setupTableView() {
        //tableView.frame = view.bounds
        with(tableView, concat(autoLayoutStyle,
                               mut(\.rowHeight, 80),
                               mut(\.delegate, self),
                               mut(\.dataSource, self)))
        tableView.removeExcessCells()

        // register cell with tableView
        tableView.register(OrderViewCell.self, forCellReuseIdentifier: OrderViewCell.reuseID)
    }
    
    // MARK: - MVVM Binding
    
    private func bind() {
        viewModel.outputs.reloadData = {
            self.tableView.reloadData()
        }
        viewModel.outputs.startElementTarget = { element in
            //guard let self = self else { return }
            self.flowDelegate?.startOrderDetailsFor(order: element)
        }
    }
    
}

// MARK: - UI Costraints

extension OrdersViewController {
    private func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        //let topConstraintConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 20 : 80

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}

// MARK: - Extension (Delegate)

extension OrdersViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didTapCellAt(indexPath: indexPath)
    }
}

// MARK: - Extension (Data Source)

extension OrdersViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //TODO: create a viewModel method to hide details
         viewModel.getElementsCount()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OrderViewCell.reuseID, for: indexPath) as! OrderViewCell
        cell.set(viewModel: viewModel.getCellViewModel(indexPath))
        return cell
    }
}
