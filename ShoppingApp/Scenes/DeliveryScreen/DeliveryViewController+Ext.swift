//
//  DeliveryViewController+Ext.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 19.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit
import Utils

extension DeliveryViewController {
    
    internal func setupFields() {
        
        firstNameTextField
            .configure(title: "orderdelivery_firstname_placeholder".localized,
                       validationRules: [RequiredRule()],
                       contentType: .username)
        
        lastNameTextField
            .configure(title: "orderdelivery_lastname_placeholder".localized,
                       validationRules: [RequiredRule()],
                       contentType: .username)
        
        phoneTextField
            .configure(title: "orderdelivery_phone_placeholder".localized,
                       validationRules: [RequiredRule()],
                       contentType: .telephoneNumber)
        
        mailTextField
            .configure(title: "orderdelivery_mail_placeholder".localized,
                       validationRules: [RequiredRule(), EmailRule()],
                       contentType: .emailAddress)
        
        billingAddressTextField
            .configure(title: "orderdelivery_billing_placeholder".localized,
                       validationRules: [RequiredRule()],
                       contentType: .streetAddressLine1)
        
        shippingAddressTextField
            .configure(title: "orderdelivery_shipping_placeholder".localized,
                       validationRules: [RequiredRule()],
                       contentType: .streetAddressLine1)
        
        cityTextField
            .configure(title: "orderdelivery_city_placeholder".localized,
                       validationRules: [RequiredRule()],
                       contentType: .addressCity)
        
        zipCodetextField
            .configure(title: "orderdelivery_zipcode_placeholder".localized,
                       validationRules: [RequiredRule()],
                       contentType: .postalCode)
        
        fields = [firstNameTextField,
                  lastNameTextField,
                  phoneTextField,
                  mailTextField,
                  billingAddressTextField,
                  shippingAddressTextField,
                  cityTextField,
                  zipCodetextField]
    }
    
    override func setupConstraints() {
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
        
        setContentViewTopAnchor(view.topAnchor)
        
        let topAnchor = getContentViewTopAnchor()
        let leadingAnchor = getContentViewLeadingAnchor()
        let trailingAnchor = getContentViewTrailingAnchor()
        //let bottomAnchor = getContentViewBottomAnchor()
        
        let topPadding = CGFloat(30)
        let hPadding = CGFloat(20)
        let fieldHeight = CGFloat(40)
        let textHeight = CGFloat(90)
        
        let buttonHeight: CGFloat = .grid_unit(13)
        
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
        
        NSLayoutConstraint.activate([
            confirmDetailsButton.topAnchor.constraint(equalTo: commentsTextView.bottomAnchor, constant: topPadding),
            confirmDetailsButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: hPadding),
            confirmDetailsButton.trailingAnchor
                .constraint(equalTo: trailingAnchor, constant: -hPadding),
            confirmDetailsButton.heightAnchor.constraint(equalToConstant: buttonHeight)
        ])
        
        setContentViewBottom(view: confirmDetailsButton)
    }
}
