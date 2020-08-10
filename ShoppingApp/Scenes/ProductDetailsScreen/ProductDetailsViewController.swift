//
//  ProductDetailsViewController.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 10.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit

final class ProductDetailsViewController: CustomScrollViewController {
    
    var viewModel: ProductDetailsViewModel
    
    var flowDelegate: ProductFlowControllerDelegate?
    
    // MARK: - Viewcontroller Lifecycle
    
    init(viewModel: ProductDetailsViewModel) {
        self.viewModel = viewModel
        super.init()
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
    internal override func setupViews() {
        super.setupViews()
        view.backgroundColor = .systemTeal
        
    }
    
    internal override func setupConstraints() {
        super.setupConstraints()
    }
    
    // MARK: - MVVM Binding
    private func bind() {
        //viewModel.outputs.
    }
}
