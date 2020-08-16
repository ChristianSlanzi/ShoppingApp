//
//  CustomTextField.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 16.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit

/// An appwide custom TextField utility class
class CustomTextField: UITextField {

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    /// init required by the API to support storyboards
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Layout Methods

    /// Configure common visual properties of TextField
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false

        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemGray4.cgColor
        
        textColor = .label
        tintColor = .label // blinking cursor
        textAlignment = .center
        font = UIFont.preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth = true
        minimumFontSize = 12

        backgroundColor = .tertiarySystemBackground
        autocorrectionType = .no
        returnKeyType = .go
        clearButtonMode = .whileEditing
        placeholder = ""
    }
    
    public func setPlaceholder(_ text: String) {
        placeholder = text
    }
}
