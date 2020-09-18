//
//  ValidableTextControl.swift
//  CustomViews
//
//  Created by Christian Slanzi on 22.02.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit
import Utils

class ValidableTextControl: UIControl {
    
    var rules: [Rule] = []
    
    var errorLabel = UILabel()
    var inputTextField = CustomTextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    init() {
        super.init(frame: CGRect.zero)
        commonInit()
    }
    
    private func commonInit() {
        self.clipsToBounds = false
        inputTextField.clipsToBounds = false
        
        errorLabel.textAlignment = .right
        errorLabel.textColor = .red
        errorLabel.font = UIFont.systemFont(ofSize: 12)
        
        addSubviews(inputTextField, errorLabel)
        setupConstraints()
    }
    
    private func setupConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
        inputTextField.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            inputTextField.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            inputTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            inputTextField.trailingAnchor
                .constraint(equalTo: trailingAnchor, constant: 0),
            inputTextField.bottomAnchor.constraint(equalTo
                : bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            errorLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            errorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            errorLabel.trailingAnchor
                .constraint(equalTo: trailingAnchor, constant: -10),
            errorLabel.bottomAnchor.constraint(equalTo
                : bottomAnchor)
        ])
    }
    
    func configure(title: String, validationRules: [Rule], contentType: UITextContentType) {
        self.inputTextField.setPlaceholder(title)
        self.inputTextField.textContentType = contentType
        self.inputTextField.isSecureTextEntry = (contentType == .password)
        self.setRules(rules: validationRules)
        self.inputTextField.delegate = self
    }
}

extension ValidableTextControl: UITextFieldDelegate {
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        self.setErrorMessage()
        return false
    }
}

extension ValidableTextControl: FieldValidatable {

    var validationText: String {
        return self.inputTextField.text ?? ""
    }
    
    
    var validationRules: [Rule] {
        get {
            return rules
        }
        set {
           rules = newValue
        }
    }
    
    func setRules(rules: [Rule]) {
        validationRules.removeAll()
        validationRules.append(contentsOf: rules)
    }
    
    func setErrorMessage() -> Void {
        errorLabel.text = self.rules
                                .filter({ !$0.validate(value: self.validationText) })
                                .first
                                .map({ $0.errorMessage() })
        
        self.setNeedsDisplay()
    }
}
