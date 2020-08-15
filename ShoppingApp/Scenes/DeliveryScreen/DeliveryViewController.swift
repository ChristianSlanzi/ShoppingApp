//
//  DeliveryViewController.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 15.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit

final class DeliveryViewController: UIViewController {
    
    // MARK: - Viewcontroller Property
    
    var viewModel: DeliveryViewModel
    
    // MARK: - FlowDelegate Property
    
    var flowDelegate: ShoppingCartFlowControllerDelegate?
    
    // MARK: - UI Properties
    
    // MARK: - Viewcontroller Lifecycle
    
    init(viewModel: DeliveryViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViews()
        setupCostraints()
        bind()
    }
    
    // MARK: - Layout Methods
    
    private func setupViews() {
        view.backgroundColor = .white
        
    }
    
    // MARK: - MVVM Binding
    
    private func bind() {

    }
}

// MARK: - UI Costraints

extension DeliveryViewController {
    private func setupCostraints() {

    }
}
