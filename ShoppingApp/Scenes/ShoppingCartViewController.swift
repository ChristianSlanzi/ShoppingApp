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
    
    //var viewModel: ProductDetailsViewModel
    
    // MARK: - FlowDelegate Property
    
    var flowDelegate: ShoppingCartFlowControllerDelegate?
    
    // MARK: - UI Properties
    
    
    // MARK: - Viewcontroller Lifecycle
    
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
    }
    
    private func setupConstraints() {
        
    }
    
    // MARK: - MVVM Binding
    
    private func bind() {
    }
}
