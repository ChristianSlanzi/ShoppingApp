//
//  OrderDetailsViewController.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 24.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit
import Overture

final class OrderDetailsViewController: CustomScrollViewController {
    
    // MARK: - Viewcontroller Property
    
    var viewModel: OrderDetailsViewModel
    
    // MARK: - FlowDelegate Property
    
    var flowDelegate: OrderFlowControllerDelegate?
    
    // MARK: - UI Properties
    
    let orderIdIcon = OrderIcon(color: Colors.darkGreen)
    var orderIdLabel = UILabel()
    var orderDateLabel = UILabel()
    let orderDateIcon = CalendarIcon()
    
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

        with(orderIdIcon, autoLayoutStyle)
        with(orderDateIcon, autoLayoutStyle)
        
        with(orderIdLabel, concat(autoLayoutStyle,
                                  mut(\.backgroundColor, .white)))
        orderIdLabel.font = .systemFont(ofSize: 14)
        orderIdLabel.text = "orderinfo_id_placeholder".localized
        
        
        with(orderDateLabel, concat(autoLayoutStyle,
                                   mut(\.backgroundColor, .white)))
        orderDateLabel.font = .systemFont(ofSize: 14)
        orderDateLabel.text = "orderinfo_date_placeholder".localized

        setupTableView()

        addToContentView(orderIdIcon,
                         orderIdLabel,
                         orderDateIcon,
                         orderDateLabel,
                         tableView
        )
    }
    
    private func setupTableView() {
        with(tableView, concat(autoLayoutStyle,
                               mut(\.rowHeight, 80),
                               mut(\.isScrollEnabled, false),
                               mut(\.dataSource, self)))
        tableView.removeExcessCells()

        // register cell with tableView
        tableView.register(OrderItemViewCell.self, forCellReuseIdentifier: OrderItemViewCell.reuseID)
    }
    
    internal override func setupConstraints() {
        super.setupConstraints()
    
        let padding: CGFloat = 20
        let labelHeight: CGFloat = 20
        
        setContentViewTopAnchor(view.topAnchor)
        
        let topAnchor = getContentViewTopAnchor()
        let leadingAnchor = getContentViewLeadingAnchor()
        let trailingAnchor = getContentViewTrailingAnchor()
        //let bottomAnchor = getContentViewBottomAnchor()
        
        NSLayoutConstraint.activate([
            orderIdIcon.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            orderIdIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            orderIdIcon.heightAnchor.constraint(equalToConstant: 20),
            orderIdIcon.widthAnchor.constraint(equalToConstant: 20),
            
            orderIdLabel.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            orderIdLabel.leadingAnchor.constraint(equalTo: orderIdIcon.trailingAnchor, constant: padding),
            orderIdLabel.trailingAnchor
                .constraint(equalTo: trailingAnchor, constant: 0),
            orderIdLabel.heightAnchor.constraint(equalToConstant: labelHeight)
        ])
        
        NSLayoutConstraint.activate([
            orderDateIcon.topAnchor.constraint(equalTo: orderIdLabel.bottomAnchor, constant: padding),
            orderDateIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            orderDateIcon.heightAnchor.constraint(equalToConstant: 20),
            orderDateIcon.widthAnchor.constraint(equalToConstant: 20),
            
            orderDateLabel.topAnchor.constraint(equalTo: orderIdLabel.bottomAnchor, constant: padding),
            
            orderDateLabel.leadingAnchor.constraint(equalTo: orderDateIcon.trailingAnchor, constant: padding),
            orderDateLabel.trailingAnchor
                .constraint(equalTo: trailingAnchor, constant: -padding),
            orderDateLabel.heightAnchor.constraint(equalToConstant: labelHeight)
        ])

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: orderDateLabel.bottomAnchor, constant: 30),
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
            self.orderIdLabel.text = id
        }
        viewModel.output.date.bind { [weak self] (date) in
            guard let self = self else { return }
            self.orderDateLabel.text = date
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
