//
//  DeliveryDTO.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 19.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation

struct DeliveryDTO: Storable {
    var firstName: String
    var lastName: String
    var phoneNumber: String
    var emailAddress: String
    var billingAddress: String
    var shippingAddress: String
    var city: String
    var zipCode: String
}

// MARK: - MappableProtocol Implementation

extension DeliveryDTO: MappableProtocol {
    
    func mapToPersistenceObject() -> DeliveryDAO {
        let delivery = DeliveryDAO()
        delivery.firstName = firstName
        delivery.lastName = lastName
        delivery.phoneNumber = phoneNumber
        delivery.emailAddress = emailAddress
        delivery.billingAddress = billingAddress
        delivery.shippingAddress = shippingAddress
        delivery.city = city
        delivery.zipCode = zipCode
        return delivery
    }
    static func mapFromPersistenceObject(_ object: DeliveryDAO) -> DeliveryDTO {
        return DeliveryDTO(firstName: object.firstName,
                           lastName: object.lastName,
                           phoneNumber: object.phoneNumber,
                           emailAddress: object.emailAddress,
                           billingAddress: object.billingAddress,
                           shippingAddress: object.shippingAddress,
                           city: object.city,
                           zipCode: object.zipCode)
    }
    
}
