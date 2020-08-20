//
//  CartRepository.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 12.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation

/// Error Messages with raw values for user display
enum CartRepositoryError: String, Error {
    case unableToSave = "There was an error saving this product. Please try again."
    case unableToUpdate = "There was an error updating this product. Please try again."
    case unableToDelete = "There was an error deleting this product. Please try again."
}

// MARK: - CartRepositoryProtocol
protocol CartRepositoryProtocol {
    
    // MARK: - CRUD Methods
    func getCartItemFor(productId: Int, completionHandler: (CartItemDTO?) -> Void)
    func getAllCartItems(on sort: Sorted?, completionHandler: ([CartItemDTO]) -> Void)
    func saveCartItem(_ cartItem: CartItemDTO)
    func updateCartItem(_ cartItem: CartItemDTO)
    func removeCartItemFor(productId: Int, completionHandler:(Bool) -> Void)
    func removeAllItems()
}

// MARK: - CartRepository
class CartRepository: BaseRepository<CartItemDTO> {
    
}

// MARK: - CartRepositoryProtocol implementation
extension CartRepository: CartRepositoryProtocol {
    
    // MARK: - Methods
    func getCartItemFor(productId: Int, completionHandler: (CartItemDTO?) -> Void) {
        super.fetch(CartItemDAO.self, predicate: NSPredicate(format: "productId = \(productId)"), sorted: nil) { (cartItems) in
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
    
    func removeCartItemFor(productId: Int, completionHandler: (Bool) -> Void) {
        
        super.fetch(CartItemDAO.self, predicate: NSPredicate(format: "productId = \(productId)"), sorted: nil) { (cartItems) in
            
            _ = cartItems.map { item in do {
                try super.delete(object: item)
                completionHandler(true)
                } catch {
                print(error.localizedDescription)
                completionHandler(false)
                }
            }
        }
    }
    
    func removeAllItems() {
        do {
            try super.deleteAll(CartItemDAO.self)
        } catch {
            print(error.localizedDescription)
        }
    }
}
