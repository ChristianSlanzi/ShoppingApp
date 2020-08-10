//
//  Order.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 10.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation

struct Order {
    var id: UInt // A unique order id
    var items: CartItem //TODO: or OrderItem?
    var createdAt: Date
    //shipping details
}
