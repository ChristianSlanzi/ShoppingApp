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
        
        firstNameTextField = CustomTextField(placeholder: "First Name")
        lastNameTextField = CustomTextField(placeholder: "Last Name")
        phoneTextField = CustomTextField(placeholder: "Telephone Number")
        mailTextField = CustomTextField(placeholder: "E-Mail Address")
        billingAddressTextField = CustomTextField(placeholder: "Billing Address")
        shippingAddressTextField = CustomTextField(placeholder: "Shipping Address")
        cityTextField = CustomTextField(placeholder: "City")
        zipCodetextField = CustomTextField(placeholder: "Zip Code")
        
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
        
        let topPadding = CGFloat(30)
        let hPadding = CGFloat(20)
        let fieldHeight = CGFloat(40)
        let textHeight = CGFloat(90)
        
        NSLayoutConstraint.activate([
            firstNameTextField.topAnchor.constraint(equalTo: topAnchor, constant: topPadding),
            firstNameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: hPadding),
            firstNameTextField.trailingAnchor
                .constraint(equalTo: trailingAnchor, constant: -hPadding),
            firstNameTextField.heightAnchor.constraint(equalToConstant: fieldHeight)
        ])
        
        NSLayoutConstraint.activate([
            lastNameTextField.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor, constant: topPadding),
            lastNameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: hPadding),
            lastNameTextField.trailingAnchor
                .constraint(equalTo: trailingAnchor, constant: -hPadding),
            lastNameTextField.heightAnchor.constraint(equalToConstant: fieldHeight)
        ])
        
        NSLayoutConstraint.activate([
            phoneTextField.topAnchor.constraint(equalTo: lastNameTextField.bottomAnchor, constant: topPadding),
            phoneTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: hPadding),
            phoneTextField.trailingAnchor
                .constraint(equalTo: trailingAnchor, constant: -hPadding),
            phoneTextField.heightAnchor.constraint(equalToConstant: fieldHeight)
        ])
        
        NSLayoutConstraint.activate([
            mailTextField.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: topPadding),
            mailTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: hPadding),
            mailTextField.trailingAnchor
                .constraint(equalTo: trailingAnchor, constant: -hPadding),
            mailTextField.heightAnchor.constraint(equalToConstant: fieldHeight)
        ])
        
        NSLayoutConstraint.activate([
            billingAddressTextField.topAnchor.constraint(equalTo: mailTextField.bottomAnchor, constant: topPadding),
            billingAddressTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: hPadding),
            billingAddressTextField.trailingAnchor
                .constraint(equalTo: trailingAnchor, constant: -hPadding),
            billingAddressTextField.heightAnchor.constraint(equalToConstant: fieldHeight)
        ])
        
        NSLayoutConstraint.activate([
            shippingAddressTextField.topAnchor.constraint(equalTo: billingAddressTextField.bottomAnchor, constant: topPadding),
            shippingAddressTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: hPadding),
            shippingAddressTextField.trailingAnchor
                .constraint(equalTo: trailingAnchor, constant: -hPadding),
            shippingAddressTextField.heightAnchor.constraint(equalToConstant: fieldHeight)
        ])
        
        NSLayoutConstraint.activate([
            cityTextField.topAnchor.constraint(equalTo: shippingAddressTextField.bottomAnchor, constant: topPadding),
            cityTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: hPadding),
            cityTextField.trailingAnchor
                .constraint(equalTo: trailingAnchor, constant: -hPadding),
            cityTextField.heightAnchor.constraint(equalToConstant: fieldHeight)
        ])
        
        NSLayoutConstraint.activate([
            zipCodetextField.topAnchor.constraint(equalTo: cityTextField.bottomAnchor, constant: topPadding),
            zipCodetextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: hPadding),
            zipCodetextField.trailingAnchor
                .constraint(equalTo: trailingAnchor, constant: -hPadding),
            zipCodetextField.heightAnchor.constraint(equalToConstant: fieldHeight)
        ])
        
        NSLayoutConstraint.activate([
            commentsTextView.topAnchor.constraint(equalTo: zipCodetextField.bottomAnchor, constant: topPadding),
            commentsTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: hPadding),
            commentsTextView.trailingAnchor
                .constraint(equalTo: trailingAnchor, constant: -hPadding),
            commentsTextView.heightAnchor.constraint(equalToConstant: textHeight)
        ])
        
        setContentViewBottom(view: commentsTextView)
    }
    
    // MARK: - MVVM Binding
    
    private func bind() {

    }
}
