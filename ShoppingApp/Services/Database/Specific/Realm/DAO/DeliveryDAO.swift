//
//  DeliveryDAO.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 19.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import RealmSwift

@objcMembers class DeliveryDAO: Object {
    
    dynamic var firstName: String = ""
    dynamic var lastName: String = ""
    dynamic var phoneNumber: String = ""
    dynamic var emailAddress: String = ""
    dynamic var billingAddress: String = ""
    dynamic var shippingAddress: String = ""
    dynamic var city: String = ""
    dynamic var zipCode: String = ""
    
    override static func primaryKey() -> String? {
        return "phoneNumber" //TODO can be a combination of fields? do I always need a primaryKey?
    }
}
