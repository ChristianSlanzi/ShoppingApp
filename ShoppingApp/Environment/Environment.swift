//
//  Environment.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 25.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation

struct Environment {

    var dataManager: AppDataManagement = AppDataManager.shared
    
    var cartRepository: CartRepositoryProtocol = CartRepository(dbManager: RealmDataManager(RealmProvider.default))
    
    var orderRepository: OrderRepositoryProtocol = OrderRepository(dbManager: RealmDataManager(RealmProvider.main))
    
    var deliveryRepository: DeliveryRepositoryProtocol = DeliveryRepository(dbManager: RealmDataManager(RealmProvider.default))
}

var Current = Environment()
