//
//  PaymentViewModel.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 17.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation

protocol PaymentViewModelInputsType {
    func viewDidLoad()
    func didTapConfirmDetailsButton()
    func validate(usingFields fields: [FieldValidatable], completion: (Bool) -> ())
}
protocol PaymentViewModelOutputsType: AnyObject {
    var updateInvalidFields: (() -> Void) { get set }
}

protocol PaymentViewModelType {
    var inputs: PaymentViewModelInputsType { get }
    var outputs: PaymentViewModelOutputsType { get }
}

final class PaymentViewModel: PaymentViewModelType, PaymentViewModelInputsType, PaymentViewModelOutputsType {
    
    struct Input {
        //passing in data the viewModel needs from the view controller
    }
    
    struct Output {
        
    }
    
    private var input: Input
    
    init(input: Input) {
        self.input = input
    }
    
    var inputs: PaymentViewModelInputsType { return self }
    var outputs: PaymentViewModelOutputsType { return self }
    
    //input
    public func viewDidLoad() {
    }
    
    func validate(usingFields fields: [FieldValidatable], completion: (Bool) -> ()) {
        
        var isValid = true
        fields.forEach { (field) in
            field.validationRules.forEach { (rule) in
                if !rule.validate(value: field.validationText) {
                    isValid = false
                    return
                }
            }
        }
        
        //TODO
        outputs.updateInvalidFields() //clear the error messages.
        
        //if isValid {
        //    self.view.updateProgress(isCompleted: false)
        //}
        completion(isValid)
    }
    
    public func didTapConfirmDetailsButton() {
        //TODO:
        // check that all fields are ok
        // save payment details
        
        // move to main screen?
        // outputs.showMainScreen()
    }

    //output
    public var updateInvalidFields: (() -> Void) = { }
    
    // MARK: - Helpers
    

}
