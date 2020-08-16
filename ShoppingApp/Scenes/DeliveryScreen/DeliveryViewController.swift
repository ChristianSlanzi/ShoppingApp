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
    
    var firstNameTextField: UITextField!
    var lastNameTextField: UITextField!
    var phoneTextField: UITextField!
    var mailTextField: UITextField!
    var billingAddressTextField: UITextField!
    var shippingAddressTextField: UITextField!
    var cityTextField: UITextField!
    var zipCodetextField: UITextField!
    
    var commentsTextView: UITextView!
    
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
        setupViews()
        setupConstraints()
        bind()
    }
    
    // MARK: - Layout Methods
    
    internal override func setupViews() {
        super.setupViews()
        view.backgroundColor = .white
        
        firstNameTextField = CustomTextField()
        lastNameTextField = CustomTextField()
        phoneTextField = CustomTextField()
        mailTextField = CustomTextField()
        billingAddressTextField = CustomTextField()
        shippingAddressTextField = CustomTextField()
        cityTextField = CustomTextField()
        zipCodetextField = CustomTextField()
        
        commentsTextView = UITextView()
        commentsTextView |> roundedStyle <> borderStyle(color: .lightGray, width: 1)
        
        addToContentView(firstNameTextField,
                         lastNameTextField,
                         phoneTextField,
                         mailTextField,
                         billingAddressTextField,
                         shippingAddressTextField,
                         cityTextField,
                         zipCodetextField,
                         commentsTextView
        )
        
    }
    
    internal override func setupConstraints() {
        super.setupConstraints()
        
        firstNameTextField.translatesAutoresizingMaskIntoConstraints = false
        lastNameTextField.translatesAutoresizingMaskIntoConstraints = false
        phoneTextField.translatesAutoresizingMaskIntoConstraints = false
        mailTextField.translatesAutoresizingMaskIntoConstraints = false
        billingAddressTextField.translatesAutoresizingMaskIntoConstraints = false
        shippingAddressTextField.translatesAutoresizingMaskIntoConstraints = false
        cityTextField.translatesAutoresizingMaskIntoConstraints = false
        zipCodetextField.translatesAutoresizingMaskIntoConstraints = false
        commentsTextView.translatesAutoresizingMaskIntoConstraints = false
        
        let topAnchor = getContentViewTopAnchor()
        let leadingAnchor = getContentViewLeadingAnchor()
        let trailingAnchor = getContentViewTrailingAnchor()
        //let bottomAnchor = getContentViewBottomAnchor()
        
        NSLayoutConstraint.activate([
            firstNameTextField.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            firstNameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            firstNameTextField.trailingAnchor
                .constraint(equalTo: trailingAnchor, constant: -20),
            firstNameTextField.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            lastNameTextField.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor, constant: 20),
            lastNameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            lastNameTextField.trailingAnchor
                .constraint(equalTo: trailingAnchor, constant: -20),
            lastNameTextField.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            phoneTextField.topAnchor.constraint(equalTo: lastNameTextField.bottomAnchor, constant: 20),
            phoneTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            phoneTextField.trailingAnchor
                .constraint(equalTo: trailingAnchor, constant: -20),
            phoneTextField.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            mailTextField.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 20),
            mailTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            mailTextField.trailingAnchor
                .constraint(equalTo: trailingAnchor, constant: -20),
            mailTextField.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            billingAddressTextField.topAnchor.constraint(equalTo: mailTextField.bottomAnchor, constant: 20),
            billingAddressTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            billingAddressTextField.trailingAnchor
                .constraint(equalTo: trailingAnchor, constant: -20),
            billingAddressTextField.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            shippingAddressTextField.topAnchor.constraint(equalTo: billingAddressTextField.bottomAnchor, constant: 20),
            shippingAddressTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            shippingAddressTextField.trailingAnchor
                .constraint(equalTo: trailingAnchor, constant: -20),
            shippingAddressTextField.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            cityTextField.topAnchor.constraint(equalTo: shippingAddressTextField.bottomAnchor, constant: 20),
            cityTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            cityTextField.trailingAnchor
                .constraint(equalTo: trailingAnchor, constant: -20),
            cityTextField.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            zipCodetextField.topAnchor.constraint(equalTo: cityTextField.bottomAnchor, constant: 20),
            zipCodetextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            zipCodetextField.trailingAnchor
                .constraint(equalTo: trailingAnchor, constant: -20),
            zipCodetextField.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            commentsTextView.topAnchor.constraint(equalTo: zipCodetextField.bottomAnchor, constant: 20),
            commentsTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            commentsTextView.trailingAnchor
                .constraint(equalTo: trailingAnchor, constant: -20),
            commentsTextView.heightAnchor.constraint(equalToConstant: 90)
        ])
        
        setContentViewBottom(view: commentsTextView)
    }
    
    // MARK: - MVVM Binding
    
    private func bind() {

    }
}
