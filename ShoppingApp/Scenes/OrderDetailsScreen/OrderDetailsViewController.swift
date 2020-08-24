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
    let tableView = UITableView()
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.reloadData()
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
        
        setupTableView()

        addToContentView(orderId,
                         orderDate,
                         tableView
        )
    }
    
    private func setupTableView() {
        //tableView.frame = view.bounds
        tableView.rowHeight = 80
        //tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        tableView.removeExcessCells()

        // register cell with tableView
        tableView.register(OrderItemViewCell.self, forCellReuseIdentifier: OrderItemViewCell.reuseID)
    }
    
    internal override func setupConstraints() {
        super.setupConstraints()
        
        orderId.translatesAutoresizingMaskIntoConstraints = false
        orderDate.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false

        let padding: CGFloat = 20
        let labelHeight: CGFloat = 20
        
        let topAnchor = getContentViewTopAnchor()
        let leadingAnchor = getContentViewLeadingAnchor()
        let trailingAnchor = getContentViewTrailingAnchor()
        //let bottomAnchor = getContentViewBottomAnchor()
        
        NSLayoutConstraint.activate([
            orderDate.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            
            orderDate.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            orderDate.trailingAnchor
                .constraint(equalTo: trailingAnchor, constant: -padding),
            orderDate.heightAnchor.constraint(equalToConstant: labelHeight)
        ])
        
        NSLayoutConstraint.activate([
            orderId.topAnchor.constraint(equalTo: orderDate.bottomAnchor, constant: padding),
            orderId.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            orderId.trailingAnchor
                .constraint(equalTo: trailingAnchor, constant: -padding),
            orderId.heightAnchor.constraint(equalToConstant: labelHeight)
        ])
        
        
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: orderId.bottomAnchor, constant: 30),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding)
        ])
        
        setContentViewBottom(view: tableView)
        
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
        viewModel.outputs.reloadData = {
            self.tableView.reloadData()
        }
    }
}

// MARK: - Extension (Data Source)

extension OrderDetailsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //TODO: create a viewModel method to hide details
        viewModel.getElementsCount()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OrderItemViewCell.reuseID, for: indexPath) as! OrderItemViewCell
        cell.set(viewModel: viewModel.getCellViewModel(indexPath))
        return cell
    }

}
