//
//  PaymentViewController+Ext.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 19.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit
import Utils
import Overture

extension PaymentViewController {
    
    internal func setupFields() {
        
        with(cardNumberTextField, concat(autoLayoutStyle))
        cardNumberTextField
            .configure(title: "payment_cardnumber_placeholder".localized,
                       validationRules: [RequiredRule()],
                       contentType: .creditCardNumber)
        
        with(expiresInTextField, concat(autoLayoutStyle))
        expiresInTextField
            .configure(title: "payment_expiration_placeholder".localized,
                       validationRules: [RequiredRule()],
                       contentType: .telephoneNumber)
        
        with(cvvTextField, concat(autoLayoutStyle))
        cvvTextField
            .configure(title: "payment_cvv_placeholder".localized,
                       validationRules: [RequiredRule()],
                       contentType: .oneTimeCode)
        
        fields = [cardNumberTextField,
                  expiresInTextField,
                  cvvTextField]
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
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
            cardNumberTextField.topAnchor.constraint(equalTo: topAnchor, constant: topPadding),
            cardNumberTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: hPadding),
            cardNumberTextField.trailingAnchor
                .constraint(equalTo: trailingAnchor, constant: -hPadding),
            cardNumberTextField.heightAnchor.constraint(equalToConstant: fieldHeight)
        ])
        
        NSLayoutConstraint.activate([
            expiresInTextField.topAnchor.constraint(equalTo: cardNumberTextField.bottomAnchor, constant: topPadding),
            expiresInTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: hPadding),
            expiresInTextField.trailingAnchor
                .constraint(equalTo: trailingAnchor, constant: -hPadding),
            expiresInTextField.heightAnchor.constraint(equalToConstant: fieldHeight)
        ])
        
        NSLayoutConstraint.activate([
            cvvTextField.topAnchor.constraint(equalTo: expiresInTextField.bottomAnchor, constant: topPadding),
            cvvTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: hPadding),
            cvvTextField.trailingAnchor
                .constraint(equalTo: trailingAnchor, constant: -hPadding),
            cvvTextField.heightAnchor.constraint(equalToConstant: fieldHeight)
        ])

        NSLayoutConstraint.activate([
            confirmDetailsButton.topAnchor.constraint(equalTo: cvvTextField.bottomAnchor, constant: topPadding),
            confirmDetailsButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: hPadding),
            confirmDetailsButton.trailingAnchor
                .constraint(equalTo: trailingAnchor, constant: -hPadding),
            confirmDetailsButton.heightAnchor.constraint(equalToConstant: buttonHeight)
        ])
        
        setContentViewBottom(view: confirmDetailsButton)
    }
}
