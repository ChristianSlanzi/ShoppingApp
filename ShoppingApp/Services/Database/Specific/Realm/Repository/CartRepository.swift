//
//  CartRepository.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 12.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import RealmSwift

/// Error Messages with raw values for user display
enum CartRepositoryError: String, Error {
    case unableToSave = "There was an error saving this product. Please try again."
    case unableToUpdate = "There was an error updating this product. Please try again."
    case unableToDelete = "There was an error deleting this product. Please try again."
}

// MARK: - CartRepositoryProtocol
protocol CartRepositoryProtocol {
    
    // MARK: - Methods
    func getCartItemFor(productId: Int, completionHandler: (CartItemDTO?) -> Void)
    func getAllCartItems(on sort: Sorted?, completionHandler: ([CartItemDTO]) -> Void)
    func saveCartItem(_ cartItem: CartItemDTO)
    func updateCartItem(_ cartItem: CartItemDTO)
    func removeCartItemFor(productId: Int, completionHandler:(Bool) -> Void)
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
    
    func removeCartItemFor(productId: Int, completionHandler: (Bool) -> Void) {
        do {
          let realm = try! Realm() //not so good... if you have multiple users, you need multiple db so it needs to be built from a configuration. //TODO
            try realm.write {
                if let realmObject = realm.objects(CartItemDAO.self).first(where: { $0.productId == productId }) {
                    realm.delete(realmObject)
                }
            }
        } catch {
            print("Something went wrong with error: \(error)")
            completionHandler(false)
        }
        
        completionHandler(true)
    }
    
}
