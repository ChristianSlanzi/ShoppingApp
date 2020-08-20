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
    
    let cartRepository: CartRepositoryProtocol
    let deliveryRepository: DeliveryRepositoryProtocol
    let orderRepository: OrderRepositoryProtocol
    
    private var input: Input
    
    init(input: Input,
         cartRepository: CartRepositoryProtocol,
         deliveryRepository: DeliveryRepositoryProtocol,
         orderRepository: OrderRepositoryProtocol) {
        self.input = input
        self.cartRepository = cartRepository
        self.deliveryRepository = deliveryRepository
        self.orderRepository = orderRepository
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
    
    public func saveOrderWithPayment(cardNumber: String,
                                     expiresIn: String,
                                     ccv: String) {
        
        // retrieve cart items
        cartRepository.getAllCartItems(on: nil) { (items) in
            guard !items.isEmpty else { return } //TODO: show error
            
            // retrieve delivery options
            deliveryRepository.getAllDeliverys(on: nil) { (deliveries) in
                guard let deliveryDTO = deliveries.first else { return } // TODO: show error
                
                // create order
                let orderDTO = OrderDTO(id: UUID().uuidString,
                                        items: items,
                                        createdAt: Date(),
                                        shipping: deliveryDTO)
                
                // save order
                orderRepository.saveOrder(order: orderDTO)
                
                // clean cart
                cartRepository.removeAllItems()
            }
            
        }
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
