//
//  PaymentViewController.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 17.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit

final class PaymentViewController: CustomScrollViewController {
    
    // MARK: - Viewcontroller Property
    
    var viewModel: PaymentViewModel
    
    // MARK: - FlowDelegate Property
    
    var flowDelegate: ShoppingCartFlowControllerDelegate?
    
    // MARK: - UI Properties
    var cardNumberTextField = ValidableTextControl()
    var expiresInTextField = ValidableTextControl()
    var cvvTextField = ValidableTextControl()
    
    var fields = [ValidableTextControl]()
    
    let confirmDetailsButton = CustomButton()
    
    // MARK: - Viewcontroller Lifecycle
    
    init(viewModel: PaymentViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        viewModel.viewDidLoad()
    }
    
    // MARK: - Layout Methods
    
    internal override func setupViews() {
        super.setupViews()
        view.backgroundColor = .systemGray
        title = "payment_screen_title".localized
        
        setupFields()
        
        confirmDetailsButton.set(backgroundColor: .systemGreen, title: "orderdelivery_confirmdetails_button".localized)
        confirmDetailsButton.addTarget(self, action: #selector(didTapConfirmDetailsButton), for: .touchUpInside)
        
        for field in fields { addToContentView(field) }
        addToContentView( confirmDetailsButton )
    }
    
    @objc private func didTapConfirmDetailsButton(_ sender: Any) {
        viewModel.validate(usingFields: fields) { (isValid) in
            if isValid {
                // We will proceed to next screen
                viewModel.inputs.didTapConfirmDetailsButton()
            }
        }
    }
    
    // MARK: - MVVM Binding
    
    private func bind() {

    }
}

