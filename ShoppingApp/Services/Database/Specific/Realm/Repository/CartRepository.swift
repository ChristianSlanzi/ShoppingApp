//
//  CartRepository.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 12.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import RealmSwift

// MARK: - CartRepositoryProtocol
protocol CartRepositoryProtocol {
    
    // MARK: - Methods
    func getCartItemFor(productId: Int, completionHandler: (CartItemDTO?) -> Void)
    func getAllCartItems(on sort: Sorted?, completionHandler: ([CartItemDTO]) -> Void)
    func saveCartItem(_ cartItem: CartItemDTO)
    func updateCartItem(_ cartItem: CartItemDTO)
}

// MARK: - CartRepository
class CartRepository: BaseRepository<CartItemDTO> {
    
}

// MARK: - CartRepositoryProtocol implementation
extension CartRepository: CartRepositoryProtocol {
    
    // MARK: - Methods
    func getCartItemFor(productId: Int, completionHandler: (CartItemDTO?) -> Void) {
        super.fetch(CartItemDAO.self, predicate: nil, sorted: nil) { (cartItems) in
            completionHandler(cartItems.map { CartItemDTO.mapFromPersistenceObject($0) }.first)
        }
    }
    func getAllCartItems(on sort: Sorted?, completionHandler: ([CartItemDTO]) -> Void) {
        super.fetch(CartItemDAO.self, predicate: nil, sorted: sort) { (cartItems) in
            completionHandler(cartItems.map { CartItemDTO.mapFromPersistenceObject($0) })
        }
    }
    
    func saveCartItem(_ cartItem: CartItemDTO) {
        do {
            try super.save(object: cartItem.mapToPersistenceObject())
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func updateCartItem(_ cartItem: CartItemDTO) {
        do {
            try super.update(object: cartItem.mapToPersistenceObject())
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
