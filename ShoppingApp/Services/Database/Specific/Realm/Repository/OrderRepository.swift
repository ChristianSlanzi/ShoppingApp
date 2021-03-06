//
//  OrderRepository.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 11.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import RealmSwift

// MARK: - OrderRepositoryProtocol
protocol OrderRepositoryProtocol {
    
    // MARK: - Methods
    func getOrderFor(orderId: String, completionHandler: (OrderDTO?) -> Void) 
    func getAllOrders(on sort: Sorted?, completionHandler: ([OrderDTO]) -> Void)
    func saveOrder(_ order: OrderDTO)
    func updateOrder(_ order: OrderDTO)
}

// MARK: - OrderRepository
class OrderRepository: BaseRepository<OrderDTO> {
    
}

// MARK: - OrderRepositoryProtocol implementation
extension OrderRepository: OrderRepositoryProtocol {
    
    // MARK: - Methods
    func getOrderFor(orderId: String, completionHandler: (OrderDTO?) -> Void) {
        
        super.fetch(OrderDAO.self, predicate: NSPredicate(format: "id == %@", orderId), sorted: nil) { (orders) in
            completionHandler(orders.map { OrderDTO.mapFromPersistenceObject($0) }.first)
        }
    }
    
    func getAllOrders(on sort: Sorted?, completionHandler: ([OrderDTO]) -> Void) {
        super.fetch(OrderDAO.self, predicate: nil, sorted: sort) { (orders) in
            completionHandler(orders.map { OrderDTO.mapFromPersistenceObject($0) })
        }
    }
    
    func saveOrder(_ order: OrderDTO) {
        do {
            try super.save(object: order.mapToPersistenceObject())
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func updateOrder(_ order: OrderDTO) {
        do {
            try super.update(object: order.mapToPersistenceObject())
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
