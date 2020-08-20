//
//  OrderDAO.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 11.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import RealmSwift

@objcMembers class OrderDAO: Object {
    
    dynamic var id: String = ""
    dynamic var items = List<CartItemDAO>()
    dynamic var createdAt = Date()
    dynamic var shipping: DeliveryDAO?
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
