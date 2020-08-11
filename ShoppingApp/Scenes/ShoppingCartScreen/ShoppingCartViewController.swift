//
//  ShoppingCartViewController.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 07.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit

final class ShoppingCartViewController: UIViewController {
    
    // MARK: - Viewcontroller Property
    
    var viewModel: ShoppingCartViewModel
    
    // MARK: - FlowDelegate Property
    
    var flowDelegate: ShoppingCartFlowControllerDelegate?
    
    // MARK: - UI Properties
    let tableView = UITableView()
    
    // MARK: - Viewcontroller Lifecycle
    
    init(viewModel: ShoppingCartViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //viewModel.viewDidLoad()
        setupViews()
        setupConstraints()
        bind()
    }
    
    // MARK: - Layout Methods
    
    private func setupViews() {
        view.backgroundColor = .systemGray
        title = "Shopping Cart"
        setupTableView()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        //tableView.frame = view.bounds
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.removeExcessCells()

        // register cell with tableView
        tableView.register(CartItemViewCell.self, forCellReuseIdentifier: CartItemViewCell.reuseID)
    }
    
    // MARK: - MVVM Binding
    
    private func bind() {
    }
}

// MARK: - UI Costraints

extension ShoppingCartViewController {
    private func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false

        //let topConstraintConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 20 : 80

        NSLayoutConstraint.activate([
            //tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstraintConstant),
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
            constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - Extension (Data Source)

extension ShoppingCartViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //TODO: create a viewModel method to hide details
        viewModel.getElementsCount()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CartItemViewCell.reuseID, for: indexPath) as! CartItemViewCell
        //TODO cell.set(favorite: viewModel.favorites[indexPath.row])
        return cell
    }

    // delete favorite
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        //TODO
        /*
        viewModel.deleteElementAt(indexPath) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success():
                tableView.deleteRows(at: [indexPath], with: .left)
                break
            case .failure(let error):
                self.presentAlertOnMainThread(title: "Unable to remove", message: error.rawValue, buttonTitle: "Ok")
                break
            }
        }
        */
    }
}

// MARK: - Extension (Delegate)

extension ShoppingCartViewController: UITableViewDelegate{
    
    // didselectrow - show followers from selected favorite
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //viewModel.didSelectRowAt(indexPath)
    }
}
