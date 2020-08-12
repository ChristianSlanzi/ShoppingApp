//
//  OrderDAO.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 11.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import RealmSwift

@objcMembers class OrderDAO: Object {
    
    dynamic var id: Int = 0
    dynamic var items = List<CartItemDAO>()
    dynamic var createdAt = Date()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}