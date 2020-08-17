//
//  PaymentViewController.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 17.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit

final class PaymentViewController: UIViewController {
    
    // MARK: - Viewcontroller Property
    
    var viewModel: PaymentViewModel
    
    // MARK: - FlowDelegate Property
    
    var flowDelegate: ShoppingCartFlowControllerDelegate?
    
    // MARK: - UI Properties

    
    // MARK: - Viewcontroller Lifecycle
    
    init(viewModel: PaymentViewModel) {
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
        title = "payment_screen_title".localized
        

    }
    
    
    // MARK: - MVVM Binding
    
    private func bind() {

    }
    

}

// MARK: - UI Costraints

extension PaymentViewController {
    private func setupConstraints() {

    }
}

