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
    var reloadData: (() -> Void) { get set }
    var updateInvalidFields: (() -> Void) { get set }
    var showOrderResultScreen: ((String) -> Void) { get set }
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
    
    private var orderId: String?
    private var input: Input
    
    init(input: Input) {
        self.input = input
    }
    
    var inputs: PaymentViewModelInputsType { return self }
    var outputs: PaymentViewModelOutputsType { return self }
    
    //input
    public func viewDidLoad() {
        Current.analytics.track(.loadedScreen(screenName: "Payment"))
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
    
    public func saveOrderWithPayment(cardNumber: String,
                                     expiresIn: String,
                                     ccv: String) {
        
        // retrieve cart items
        Current.cartRepository.getAllCartItems(on: nil) { (items) in
            guard !items.isEmpty else { return } //TODO: show error
            
            // retrieve delivery options
            Current.deliveryRepository.getAllDeliverys(on: nil) { (deliveries) in
                guard let deliveryDTO = deliveries.first else { return } // TODO: show error
                
                // create order
                orderId = UUID().uuidString
                guard let orderId = orderId else { return }
                let orderDTO = OrderDTO(id: orderId,
                                        items: items,
                                        createdAt: Date(),
                                        shipping: deliveryDTO)
                
                // save order
                Current.orderRepository.saveOrder(orderDTO)
                
                // clean cart
                Current.cartRepository.removeAllItems()
            }
            
        }
    }
    
    public func didTapConfirmDetailsButton() {
        guard let orderId = orderId else { return }
        outputs.showOrderResultScreen(orderId)
    }

    //output
    public var reloadData: (() -> Void) = { }
    public var updateInvalidFields: (() -> Void) = { }
    public var showOrderResultScreen: ((String) -> Void) = { _ in }
    
    // MARK: - Helpers
    
}
