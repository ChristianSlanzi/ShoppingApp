//
//  Product.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 08.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation

struct Product: Equatable {
    var id: Int // A unique product id number among all products of all categories
    var categoryId: Int
    var name: String
    var description: String
    var imageUrl: String
    var price: Double
    var currency: String //TODO: create Currency enum
}
