//
//  AppDataManager.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 08.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation

class AppDataManager {

    // MARK: - SHARED INSTANCE
    static let shared = AppDataManager()
    
    private var categories = [Category]()
    private var products = [Product]()
    
    private init() {
        setupData()
    }
    
    // MARK: - PUBLIC METHODS
    public func getAllCategoriesCount() -> Int {
        return categories.count
    }
    
    public func getAllCategories() -> [Category] {
        return categories
    }
    
    public func getCategoryAt(index: Int) -> Category? {
        guard index < categories.count else { return nil }
        return categories[index]
    }
    
    public func getAllProductsCount() -> Int {
        return products.count
    }
    
    public func getAllProducts() -> [Product] {
        return products
    }
    
    public func getAllProductsFor(categoryId: Int) -> [Product] {
        return products
    }
    
    public func getProductAt(index: Int) -> Product? {
        guard index < products.count else { return nil }
        return products[index]
    }
}

// MARK: - EXTENSIONS
extension AppDataManager {
    
    private func setupData() {
        let categories = [
            Category(id: 0, name: "Sales", description: "Sales tools", imageUrl: "img_"+"sales"),
            Category(id: 1, name: "Decor", description: "Decor tools", imageUrl: "img_"+"decor"),
            Category(id: 2, name: "Bed & Bath", description: "Bed & Bath tools", imageUrl: "img_"+"bedbath"),
            Category(id: 3, name: "Furniture", description: "Furniture tools", imageUrl: "img_"+"furniture"),
            Category(id: 4, name: "Kitchen", description: "Kitchen tools", imageUrl: "img_"+"kitchen"),
            Category(id: 5, name: "Dining & Entertaining", description: "Dining & Entertaining tools", imageUrl: "img_"+"dining"),
            Category(id: 6, name: "Outdoor & Garden", description: "Outdoor & Garden tools", imageUrl: "img_"+"outdoor"),
            Category(id: 7, name: "Holidays", description: "Holidays tools", imageUrl: "img_"+"holidays"),
            Category(id: 8, name: "Cleaning", description: "Cleaning tools", imageUrl: "img_"+"cleaning")
        ]
        self.categories = categories
        
        let products = [
            Product(id: 0, categoryId: 0, name: "Product 0", description: "Product 0 description", imageUrl: "img_"+"product0", price: 20, currency: "Euro"),
            Product(id: 1, categoryId: 0, name: "Product 1", description: "Product 1 description", imageUrl: "img_"+"product1", price: 10, currency: "Euro"),
            Product(id: 2, categoryId: 0, name: "Product 2", description: "Product 2 description", imageUrl: "img_"+"product2", price: 15, currency: "Euro"),
            Product(id: 3, categoryId: 0, name: "Product 3", description: "Product 3 description", imageUrl: "img_"+"product3", price: 20, currency: "Euro"),
            Product(id: 4, categoryId: 0, name: "Product 4", description: "Product 4 description", imageUrl: "img_"+"product4", price: 30, currency: "Euro"),
            Product(id: 5, categoryId: 0, name: "Product 5", description: "Product 5 description", imageUrl: "img_"+"product5", price: 25, currency: "Euro"),
            Product(id: 6, categoryId: 0, name: "Product 6", description: "Product 6 description", imageUrl: "img_"+"product6", price: 23.5, currency: "Euro"),
            Product(id: 7, categoryId: 0, name: "Product 7", description: "Product 7 description", imageUrl: "img_"+"product7", price: 11, currency: "Euro"),
            Product(id: 8, categoryId: 0, name: "Product 8", description: "Product 8 description", imageUrl: "img_"+"product8", price: 99.9, currency: "Euro")
        ]
        self.products = products
    }
}
