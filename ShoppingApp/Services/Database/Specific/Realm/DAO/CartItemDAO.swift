//
//  CartItemDAO.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 11.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import RealmSwift

@objcMembers class CartItemDAO: Object {
    
    dynamic var productId: Int = 0
    dynamic var quantity: Int = 0
    
    override static func primaryKey() -> String? {
        return "productId"
    }
}
