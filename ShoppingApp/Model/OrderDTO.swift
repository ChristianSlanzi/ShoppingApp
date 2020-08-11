//
//  Order.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 10.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation

struct OrderDTO: Storable {
    var id: Int // A unique order id
    var items: [CartItemDTO] //TODO: or OrderItem?
    var createdAt: Date
    //shipping details
}

// MARK: - MappableProtocol Implementation

extension OrderDTO: MappableProtocol {
    func mapToPersistenceObject() -> OrderDAO {
        let order = OrderDAO()
        order.id = id

        return order
    }
    static func mapFromPersistenceObject(_ object: OrderDAO) -> OrderDTO {
        return OrderDTO(id: object.id,
                        items: object.items.map({ (itemDao) -> CartItemDTO in
                            return CartItemDTO(productId: itemDao.productId, quantity: itemDao.quantity)
                        }),
                        createdAt: object.createdAt)
    }
}
