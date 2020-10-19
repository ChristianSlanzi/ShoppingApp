//
//  DeliveryViewModel.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 15.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation
import CS_Common_Utils

protocol DeliveryViewModelInputsType {
    func viewDidLoad()
    func didTapConfirmDetailsButton()
    func validate(usingFields fields: [FieldValidatable], completion: (Bool) -> ())
    func saveDeliveryDetails(firstName: String,
                             lastName: String,
                             phoneNumber: String,
                             email: String,
                             billAddress: String,
                             shipAddress: String,
                             city: String,
                             zip: String)
}
protocol DeliveryViewModelOutputsType: AnyObject {
    var reloadData: (() -> Void) { get set }
    var updateInvalidFields: (() -> Void) { get set }
    var showPaymentScreen: (() -> Void) { get set }
}

protocol DeliveryViewModelType {
    var inputs: DeliveryViewModelInputsType { get }
    var outputs: DeliveryViewModelOutputsType { get }
}

final class DeliveryViewModel: DeliveryViewModelType, DeliveryViewModelInputsType, DeliveryViewModelOutputsType {
    
    private var elements: [DeliveryDTO] = []
    
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
        Current.analytics.track(.loadedScreen(screenName: "Delivery Options"))
        Current.deliveryRepository.getAllDeliverys(on: nil) { (items) in
            self.elements = items
        }
        self.outputs.reloadData()
    }
    
    public func validate(usingFields fields: [FieldValidatable], completion: (Bool) -> ()) {
        
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
    
    public func saveDeliveryDetails(firstName: String,
                                    lastName: String,
                                    phoneNumber: String,
                                    email: String,
                                    billAddress: String,
                                    shipAddress: String,
                                    city: String,
                                    zip: String) {
        
        // create delivery data transfer object
        let deliveryDTO = DeliveryDTO(firstName: firstName,
                                      lastName: lastName,
                                      phoneNumber: phoneNumber,
                                      emailAddress: email,
                                      billingAddress: billAddress,
                                      shippingAddress: shipAddress,
                                      city: city,
                                      zipCode: zip)
        
        // save delivery details
        Current.deliveryRepository.getDeliveryFor(phoneNumber: deliveryDTO.phoneNumber) { (item) in
            guard item != nil else {
                Current.deliveryRepository.saveDelivery(delivery: deliveryDTO)
                return
            }
            Current.deliveryRepository.updateDelivery(deliveryDTO)
        }
    }
    
    public func didTapConfirmDetailsButton() {
        // move to payment screen
        outputs.showPaymentScreen()
    }

    //output
    public var reloadData: (() -> Void) = { }
    public var updateInvalidFields: (() -> Void) = { }
    public var showPaymentScreen: (() -> Void) = { }
    
    // MARK: - Helpers
    public func getElementAt(_ indexPath: IndexPath) -> DeliveryDTO? {
        guard indexPath.row < elements.count else { return nil }
        return elements[indexPath.row]
    }

}
