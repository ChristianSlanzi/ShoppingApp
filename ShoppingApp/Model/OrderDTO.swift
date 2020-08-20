//
//  Order.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 10.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation

struct OrderDTO: Storable {
    var id: String // A unique order id
    var items: [CartItemDTO] //TODO: or OrderItem?
    var createdAt: Date
    //shipping details
    var shipping: DeliveryDTO
}

// MARK: - MappableProtocol Implementation

extension OrderDTO: MappableProtocol {
    func mapToPersistenceObject() -> OrderDAO {
        let order = OrderDAO()
        order.id = id
        order.createdAt = createdAt
        let shippingDao = DeliveryDAO()
        shippingDao.firstName = shipping.firstName
        shippingDao.lastName = shipping.lastName
        shippingDao.phoneNumber = shipping.phoneNumber
        shippingDao.emailAddress = shipping.emailAddress
        shippingDao.billingAddress = shipping.billingAddress
        shippingDao.shippingAddress = shipping.shippingAddress
        shippingDao.city = shipping.city
        shippingDao.zipCode = shipping.zipCode

        return order
    }
    static func mapFromPersistenceObject(_ object: OrderDAO) -> OrderDTO {
        return OrderDTO(id: object.id,
                        items: object.items.map({ (itemDao) -> CartItemDTO in
                            return CartItemDTO(productId: itemDao.productId, quantity: itemDao.quantity)
                        }),
                        createdAt: object.createdAt,
                        shipping: DeliveryDTO(firstName: object.shipping!.firstName,
                                              lastName: object.shipping!.lastName,
                                              phoneNumber: object.shipping!.phoneNumber,
                                              emailAddress: object.shipping!.emailAddress,
                                              billingAddress: object.shipping!.billingAddress,
                                              shippingAddress: object.shipping!.shippingAddress,
                                              city: object.shipping!.city,
                                              zipCode: object.shipping!.zipCode))
    }
}
