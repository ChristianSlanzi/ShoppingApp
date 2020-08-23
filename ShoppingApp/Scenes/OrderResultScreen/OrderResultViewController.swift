//
//  OrderResultScreen.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 21.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit

final class OrderResultViewController: UIViewController {
    
    // MARK: - Viewcontroller Property
    
    var viewModel: OrderResultViewModel
    
    // MARK: - FlowDelegate Property
    
    var flowDelegate: ShoppingCartFlowControllerDelegate?
    
    // MARK: - UI Properties
    let tableView = UITableView()
    let mainScreenButton = CustomButton()
    
    // MARK: - Viewcontroller Lifecycle
    
    init(viewModel: OrderResultViewModel) {
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
        title = "order_result_screen_title".localized
        
        setupTableView()
        
        mainScreenButton.set(backgroundColor: .systemGreen, title: "order_result_mainscreen_button".localized)
        mainScreenButton.addTarget(self, action: #selector(didTapMainScreenButton), for: .touchUpInside)
        
        view.addSubviews(tableView, mainScreenButton)
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
        viewModel.outputs.reloadData = {
            self.tableView.reloadData()
        }
        viewModel.outputs.showMainScreen = {
            //guard let self = self else { return }
            self.flowDelegate?.backToMainScreen()
        }
    }
    
    @objc private func didTapMainScreenButton(_ sender: Any) {
        viewModel.inputs.didTapMainScreenButton()
    }
}

// MARK: - UI Costraints

extension OrderResultViewController {
    private func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        mainScreenButton.translatesAutoresizingMaskIntoConstraints = false
        
        //let topConstraintConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 20 : 80

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: mainScreenButton.topAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            mainScreenButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            mainScreenButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            mainScreenButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            mainScreenButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

// MARK: - Extension (Data Source)

extension OrderResultViewController: UITableViewDataSource {

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
