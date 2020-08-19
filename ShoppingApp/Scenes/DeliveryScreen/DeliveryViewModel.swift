//
//  DeliveryViewModel.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 15.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation

protocol DeliveryViewModelInputsType {
    func viewDidLoad()
    func didTapConfirmDetailsButton()
    func validate(usingFields fields: [FieldValidatable], completion: (Bool) -> ())
}
protocol DeliveryViewModelOutputsType: AnyObject {
    var updateInvalidFields: (() -> Void) { get set }
    var showPaymentScreen: (() -> Void) { get set }
}

protocol DeliveryViewModelType {
    var inputs: DeliveryViewModelInputsType { get }
    var outputs: DeliveryViewModelOutputsType { get }
}

final class DeliveryViewModel: DeliveryViewModelType, DeliveryViewModelInputsType, DeliveryViewModelOutputsType {
    
    struct Input {
        //passing in data the viewModel needs from the view controller
    }
    
    struct Output {
        
    }
    
    private var input: Input
    
    init(input: Input) {
        self.input = input
    }
    
    var inputs: DeliveryViewModelInputsType { return self }
    var outputs: DeliveryViewModelOutputsType { return self }
    
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
        // save delivery details
        
        // move to payment screen
        outputs.showPaymentScreen()
    }

    //output
    public var updateInvalidFields: (() -> Void) = { }
    public var showPaymentScreen: (() -> Void) = { }
    
    // MARK: - Helpers
    

}
