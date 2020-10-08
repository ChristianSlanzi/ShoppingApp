//
//  DeliveryViewController.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 15.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit
import Utils
import Overture

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
    
    var commentsTextView = UITextView()
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
        bind()
        viewModel.viewDidLoad()
    }
    
    // MARK: - Layout Methods
    
    internal override func setupViews() {
        super.setupViews()
        view.backgroundColor = .white
        title = "orderdelivery_screen_title".localized
        
        setupFields()
        
        with(commentsTextView, concat(autoLayoutStyle, baseRoundedStyle))
        commentsTextView |> borderStyle(color: .lightGray, width: 1)
        
        with(confirmDetailsButton, primaryButtonStyle)
        confirmDetailsButton.setTitle("orderdelivery_confirmdetails_button".localized)
        
        for field in fields { addToContentView(field) }
        addToContentView( commentsTextView, confirmDetailsButton )
    }
    
    @objc private func didConfirmDetails() {
        viewModel.validate(usingFields: fields) { (isValid) in
            if isValid {
                // Create and save Delivery
                viewModel.inputs.saveDeliveryDetails(firstName: firstNameTextField.validationText,
                                                     lastName: lastNameTextField.validationText,
                                                     phoneNumber: phoneTextField.validationText,
                                                     email: mailTextField.validationText,
                                                     billAddress: billingAddressTextField.validationText,
                                                     shipAddress: shippingAddressTextField.validationText,
                                                     city: cityTextField.validationText,
                                                     zip: zipCodetextField.validationText)
                // We will proceed to next screen
                viewModel.inputs.didTapConfirmDetailsButton()
            }
        }
    }
        
    // MARK: - MVVM Binding
    
    private func bind() {
        // Input
        confirmDetailsButton.didTouchUpInside = { (sender) in
            self.didConfirmDetails()
        }
        
        // Output
        viewModel.outputs.reloadData = { [weak self] in
            guard let self = self else { return }

            DispatchQueue.main.async {
                guard let delivery = self.viewModel.getElementAt(IndexPath(row: 0, section: 0)) else { return }
                self.firstNameTextField.inputTextField.text = delivery.firstName
                self.lastNameTextField.inputTextField.text = delivery.lastName
                self.phoneTextField.inputTextField.text = delivery.phoneNumber
                self.mailTextField.inputTextField.text = delivery.emailAddress
                self.billingAddressTextField.inputTextField.text = delivery.billingAddress
                self.shippingAddressTextField.inputTextField.text = delivery.shippingAddress
                self.cityTextField.inputTextField.text = delivery.city
                self.zipCodetextField.inputTextField.text = delivery.zipCode
            }
        }
        
        viewModel.outputs.showPaymentScreen = {
            self.flowDelegate?.startPayment()
        }
        
        viewModel.outputs.updateInvalidFields = {
            for field in self.fields { field.setErrorMessage() }
        }
    }
}
