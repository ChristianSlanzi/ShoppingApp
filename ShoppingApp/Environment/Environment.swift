//
//  Environment.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 25.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation

struct Environment {
    
    var analytics = Analytics()

    var dataManager: AppDataManagement = AppDataManager.shared
    
    var cartRepository: CartRepositoryProtocol = CartRepository(dbManager: RealmDataManager(RealmProvider.default))
    
    var orderRepository: OrderRepositoryProtocol = OrderRepository(dbManager: RealmDataManager(RealmProvider.main))
    
    var deliveryRepository: DeliveryRepositoryProtocol = DeliveryRepository(dbManager: RealmDataManager(RealmProvider.default))
}

var Current = Environment()//Environment.mock//


// MARK: - Mock Environment

extension Environment {
    static let mock = Environment(analytics: .mock,
                                  dataManager: AppDataManager.mock,
                                  cartRepository: CartRepository.mock,
                                  orderRepository: OrderRepository.mock,
                                  deliveryRepository: DeliveryRepository.mock)
}

extension Analytics {
    static let mock = Analytics(track: { event in
        print("Mock track", event)
    })
}

extension AppDataManager {
    static let mock = AppDataManager.shared //app data manager is currently a mock
}

extension CartRepository {
    static let mock = CartRepository(dbManager: RealmDataManager(RealmProvider.mock))
}
extension OrderRepository {
    static let mock = OrderRepository(dbManager: RealmDataManager(RealmProvider.mock))
}
extension DeliveryRepository {
    static let mock = DeliveryRepository(dbManager: RealmDataManager(RealmProvider.mock))
}
