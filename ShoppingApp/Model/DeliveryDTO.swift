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
