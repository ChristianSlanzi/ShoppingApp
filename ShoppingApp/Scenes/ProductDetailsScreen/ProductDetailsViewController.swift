//
//  ProductDetailsViewController.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 10.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit

final class ProductDetailsViewController: UIViewController {
    
    var viewModel: ProductDetailsViewModel
    
    var flowDelegate: ProductFlowControllerDelegate?
    
    // MARK: - Viewcontroller Lifecycle
    
    init(viewModel: ProductDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        bind()
        viewModel.viewDidLoad()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    // MARK: - Layout Methods
    private func setupViews() {
        view.backgroundColor = .systemTeal
        
    }
    
    // MARK: - MVVM Binding
    private func bind() {
        //viewModel.outputs.
    }
}

// MARK: - UI Costraints

extension ProductDetailsViewController {
    
    private func setupConstraints() {
        
    }
}
