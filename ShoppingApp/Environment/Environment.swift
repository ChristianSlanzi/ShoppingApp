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
    var calendar = Calendar.autoupdatingCurrent
    var date: () -> Date = Date.init
    var device = Device()
    var screen = Screen()
    var version = Version()
    
    var dataManager: AppDataManagement = AppDataManager.shared
    
    var cartRepository: CartRepositoryProtocol = CartRepository(dbManager: RealmDataManager(RealmProvider.default))
    
    var orderRepository: OrderRepositoryProtocol = OrderRepository(dbManager: RealmDataManager(RealmProvider.main))
    
    var deliveryRepository: DeliveryRepositoryProtocol = DeliveryRepository(dbManager: RealmDataManager(RealmProvider.default))
    
    var theme: Theme = SettingsService.shared.appTheme
}

var Current = Environment()
//var Current = Environment.mock

// MARK: - Mock Environment

// ====================================================
//
//                  Dependency Mocks
//
// ====================================================

extension Environment {
    static let mock = Environment(analytics: .mock,
                                  calendar: .mock,
                                  date: { .mock },
                                  device: .mock,
                                  screen: .mock,
                                  version: .mock,
                                  dataManager: AppDataManager.mock,
                                  cartRepository: CartRepository.mock,
                                  orderRepository: OrderRepository.mock,
                                  deliveryRepository: DeliveryRepository.mock
                                  )
}

extension Analytics {
    static let mock = Analytics(track: { event in
        print("Mock track", event)
    })
}

extension Date {
    static let mock = Date(timeIntervalSinceReferenceDate: 557152051)
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

extension Device {
    static let mock = Device(systemName: "Mock iOS", systemVersion: "11.mock")
}

extension Screen {
    static let mock = Screen(height: "568", width: "376")
}

extension Version {
    static let mock = Version(build: "42", release: "0.0.1")
}

extension Calendar {
    static let mock = Calendar(identifier: .gregorian)
}
//TODO: extract Locale

