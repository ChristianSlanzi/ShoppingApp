//
//  CartItem.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 10.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation

struct CartItemDTO: Storable {
    let productId: Int
    let quantity: Int
}

// MARK: - MappableProtocol Implementation

extension CartItemDTO: MappableProtocol {
    func mapToPersistenceObject() -> CartItemDAO {
        let item = CartItemDAO()
        item.productId = productId

        return item
    }
    static func mapFromPersistenceObject(_ object: CartItemDAO) -> CartItemDTO {
        return CartItemDTO(productId: object.productId, quantity: object.quantity)
    }
}
