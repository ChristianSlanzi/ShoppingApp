//
//  DeliveryViewController.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 15.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit

final class DeliveryViewController: CustomScrollViewController {
    
    // MARK: - Viewcontroller Property
    
    var viewModel: DeliveryViewModel
    
    // MARK: - FlowDelegate Property
    
    var flowDelegate: ShoppingCartFlowControllerDelegate?
    
    // MARK: - UI Properties
    let firstNameTextField = ValidableTextControl()
    let lastNameTextField = ValidableTextControl()
    let phoneTextField = ValidableTextControl()
    let mailTextField = ValidableTextControl()
    let billingAddressTextField = ValidableTextControl()
    let shippingAddressTextField = ValidableTextControl()
    let cityTextField = ValidableTextControl()
    let zipCodetextField = ValidableTextControl()
    
    var fields = [ValidableTextControl]()
    
    var commentsTextView: UITextView!
    let confirmDetailsButton = CustomButton()
    
    // MARK: - Viewcontroller Lifecycle
    
    init(viewModel: DeliveryViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        bind()
    }
    
    // MARK: - Layout Methods
    
    internal override func setupViews() {
        super.setupViews()
        view.backgroundColor = .white
        title = "orderdelivery_screen_title".localized
        
        setupFields()
                    
        commentsTextView = UITextView()
        commentsTextView |> roundedStyle <> borderStyle(color: .lightGray, width: 1)
        
        confirmDetailsButton.set(backgroundColor: .systemGreen, title: "orderdelivery_confirmdetails_button".localized)
        confirmDetailsButton.addTarget(self, action: #selector(didTapConfirmDetailsButton), for: .touchUpInside)
        
        for field in fields { addToContentView(field) }
        addToContentView( commentsTextView, confirmDetailsButton )
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
        viewModel.outputs.showPaymentScreen = {
            self.flowDelegate?.startPayment()
        }
        
        viewModel.outputs.updateInvalidFields = {
            for field in self.fields { field.setErrorMessage() }
        }
    }
}
