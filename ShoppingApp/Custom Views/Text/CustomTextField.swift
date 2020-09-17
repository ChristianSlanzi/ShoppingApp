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
    
    enum Style {
        case none
        case rounded
        case underlined
    }

    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    
    var floatingLabel: UILabel = UILabel(frame: CGRect.zero) // Label
    var floatingLabelHeight: CGFloat = 12 // Default height
    
    var textPlaceholder: String? // we cannot override 'placeholder'
    
    var floatingLabelColor: UIColor = UIColor.gray {
        didSet {
            self.floatingLabel.textColor = floatingLabelColor
            self.setNeedsDisplay()
        }
    }
    
    var activeBorderColor: UIColor = UIColor.lightGray
    
    var style: Style = .none
    
    var floatingLabelFont: UIFont = UIFont.systemFont(ofSize: 12) {
        didSet {
            self.floatingLabel.font = self.floatingLabelFont
            self.font = self.floatingLabelFont
            self.setNeedsDisplay()
        }
    }
    // MARK: - Initializers
    init(placeholder: String, style: Style = .none) {
        self.textPlaceholder = placeholder
        self.style = style
        super.init(frame: .zero)
        configure()
    }

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

        if style == .rounded {
            layer.cornerRadius = 10
            layer.borderWidth = 2
            layer.borderColor = UIColor.lightGray.cgColor
        }
        
        textColor = .gray
        tintColor = .gray // blinking cursor
        textAlignment = .left
        font = UIFont.preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth = true
        minimumFontSize = 12

        backgroundColor = .white
        autocorrectionType = .no
        returnKeyType = .go
        clearButtonMode = .whileEditing
        
        self.textPlaceholder = (self.textPlaceholder != nil) ? self.textPlaceholder : placeholder // Use our custom placeholder if none is set
        placeholder = self.textPlaceholder // make sure the placeholder is shown
        self.floatingLabel = UILabel(frame: CGRect.zero)
        self.addTarget(self, action: #selector(self.addUnderline), for: .init())
        self.addTarget(self, action: #selector(self.addFloatingLabel), for: .editingDidBegin)
        self.addTarget(self, action: #selector(self.removeFloatingLabel), for: .editingDidEnd)
    }
    
    public func setPlaceholder(_ text: String) {
        placeholder = text
        self.textPlaceholder = placeholder
    }
    
    // Add underline
    @objc func addUnderline() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.lightGray.cgColor
        self.borderStyle = UITextField.BorderStyle.none
        self.layer.addSublayer(bottomLine)
        
        self.setNeedsDisplay()
    }
    
    // Add a floating label to the view on becoming first responder
    @objc func addFloatingLabel() {
        if self.text == "" {
            self.floatingLabel.textColor = floatingLabelColor
            self.floatingLabel.font = floatingLabelFont
            self.floatingLabel.text = self.textPlaceholder
            self.floatingLabel.layer.backgroundColor = UIColor.white.cgColor
            self.floatingLabel.translatesAutoresizingMaskIntoConstraints = false
            self.floatingLabel.clipsToBounds = true
            self.floatingLabel.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.floatingLabelHeight)
            self.layer.borderColor = self.activeBorderColor.cgColor
            self.addSubview(self.floatingLabel)
          
            self.floatingLabel.bottomAnchor.constraint(equalTo:
            self.topAnchor, constant: -2).isActive = true // Place our label 10pts above the text field
            // Remove the placeholder
            self.placeholder = ""
        }
        self.setNeedsDisplay()
    }
    
    @objc func removeFloatingLabel() {
        if self.text == "" {
            UIView.animate(withDuration: 0.13) {
               self.subviews.forEach{ $0.removeFromSuperview() }
               self.setNeedsDisplay()
            }
            self.placeholder = self.textPlaceholder
        }
        self.layer.borderColor = UIColor.lightGray.cgColor
    }

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        if style == .underlined {
            addUnderline()
        }
    }
}
