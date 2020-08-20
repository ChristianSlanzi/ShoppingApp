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
    func saveDeliveryDetails(_ deliveryDTO: DeliveryDTO)
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
    
    let deliveryRepository: DeliveryRepositoryProtocol
    
    private var input: Input
    
    init(input: Input, deliveryRepository: DeliveryRepositoryProtocol) {
        self.input = input
        self.deliveryRepository = deliveryRepository
    }
    
    var inputs: DeliveryViewModelInputsType { return self }
    var outputs: DeliveryViewModelOutputsType { return self }
    
    //input
    public func viewDidLoad() {
        deliveryRepository.getAllDeliverys(on: nil) { (items) in
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
    
    public func saveDeliveryDetails(_ deliveryDTO: DeliveryDTO) {
        // save delivery details
        deliveryRepository.getDeliveryFor(phoneNumber: deliveryDTO.phoneNumber) { (item) in
            guard item != nil else {
                deliveryRepository.saveDelivery(delivery: deliveryDTO)
                return
            }
            deliveryRepository.updateDelivery(deliveryDTO)
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
