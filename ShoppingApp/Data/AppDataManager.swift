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
    
    public func getAllProductsCountFor(categoryId: Int) -> Int {
        return getAllProductsFor(categoryId: categoryId).count
    }
    
    public func getAllProductsFor(categoryId: Int) -> [Product] {
        return products.filter { (product) -> Bool in
            return product.categoryId == categoryId
        }
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
            Category(id: 0, name: "category_0_name".localized, description: "category_0_description".localized, imageUrl: "category_0_image".localized),
            Category(id: 1, name: "Bath", description: "Bath tools", imageUrl: "cat-"+"bathroom"),
            Category(id: 2, name: "Bedroom", description: "Bedroom tools", imageUrl: "cat-"+"bedroom"),
            Category(id: 3, name: "Office", description: "Office tools", imageUrl: "cat-"+"office"),
            Category(id: 4, name: "Kitchen", description: "Kitchen tools", imageUrl: "cat-"+"kitchen"),
            Category(id: 5, name: "Dining & Entertaining", description: "Dining & Entertaining tools", imageUrl: "cat-"+"dining"),
            Category(id: 6, name: "Outdoor & Garden", description: "Outdoor & Garden tools", imageUrl: "cat-"+"garden"),
            Category(id: 7, name: "Holidays", description: "Holidays tools", imageUrl: "cat-"+"holidays"),
            Category(id: 8, name: "Cleaning", description: "Cleaning tools", imageUrl: "cat-"+"cleaning"),
            Category(id: 9, name: "Decor", description: "Decor tools", imageUrl: "cat-"+"decor")
        ]
        self.categories = categories
        
        let products = [
            // Category 0
            Product(id: 0, categoryId: 0, name: "Cat 0 Product 0", description: "Cat 0 Product 0 description", imageUrl: "img_"+"product0", price: 20, currency: "Euro"),
            Product(id: 1, categoryId: 0, name: "Cat 0 Product 1", description: "Cat 0 Product 1 description", imageUrl: "img_"+"product1", price: 10, currency: "Euro"),
            Product(id: 2, categoryId: 0, name: "Cat 0 Product 2", description: "Cat 0 Product 2 description", imageUrl: "img_"+"product2", price: 15, currency: "Euro"),
            Product(id: 3, categoryId: 0, name: "Cat 0 Product 3", description: "Cat 0 Product 3 description", imageUrl: "img_"+"product3", price: 20, currency: "Euro"),
            Product(id: 4, categoryId: 0, name: "Cat 0 Product 4", description: "Cat 0 Product 4 description", imageUrl: "img_"+"product4", price: 30, currency: "Euro"),
            Product(id: 5, categoryId: 0, name: "Cat 0 Product 5", description: "Cat 0 Product 5 description", imageUrl: "img_"+"product5", price: 25, currency: "Euro"),
            Product(id: 6, categoryId: 0, name: "Cat 0 Product 6", description: "Cat 0 Product 6 description", imageUrl: "img_"+"product6", price: 23.5, currency: "Euro"),
            Product(id: 7, categoryId: 0, name: "Cat 0 Product 7", description: "Cat 0 Product 7 description", imageUrl: "img_"+"product7", price: 11, currency: "Euro"),
            Product(id: 8, categoryId: 0, name: "Cat 0 Product 8", description: "Cat 0 Product 8 description", imageUrl: "img_"+"product8", price: 99.9, currency: "Euro"),
            // Category 1
            Product(id: 10, categoryId: 1, name: "Cat 1 Product 0", description: "Cat 1 Product 0 description", imageUrl: "img_"+"product0", price: 20, currency: "Euro"),
            Product(id: 11, categoryId: 1, name: "Cat 1 Product 1", description: "Cat 1 Product 1 description", imageUrl: "img_"+"product1", price: 10, currency: "Euro"),
            Product(id: 12, categoryId: 1, name: "Cat 1 Product 2", description: "Cat 1 Product 2 description", imageUrl: "img_"+"product2", price: 15, currency: "Euro"),
            Product(id: 13, categoryId: 1, name: "Cat 1 Product 3", description: "Cat 1 Product 3 description", imageUrl: "img_"+"product3", price: 20, currency: "Euro"),
            // Category 2
            Product(id: 10, categoryId: 2, name: "Cat 2 Product 0", description: "Cat 2 Product 0 description", imageUrl: "img_"+"product0", price: 20, currency: "Euro"),
            Product(id: 11, categoryId: 2, name: "Cat 2 Product 1", description: "Cat 2 Product 1 description", imageUrl: "img_"+"product1", price: 10, currency: "Euro"),
            Product(id: 12, categoryId: 2, name: "Cat 2 Product 2", description: "Cat 2 Product 2 description", imageUrl: "img_"+"product2", price: 15, currency: "Euro"),
            Product(id: 13, categoryId: 2, name: "Cat 2 Product 3", description: "Cat 2 Product 3 description", imageUrl: "img_"+"product3", price: 20, currency: "Euro"),
            // Category 3
            Product(id: 10, categoryId: 3, name: "Cat 3 Product 0", description: "Cat 3 Product 0 description", imageUrl: "img_"+"product0", price: 20, currency: "Euro"),
            Product(id: 11, categoryId: 3, name: "Cat 3 Product 1", description: "Cat 3 Product 1 description", imageUrl: "img_"+"product1", price: 10, currency: "Euro"),
            Product(id: 12, categoryId: 3, name: "Cat 3 Product 2", description: "Cat 3 Product 2 description", imageUrl: "img_"+"product2", price: 15, currency: "Euro"),
            Product(id: 13, categoryId: 3, name: "Cat 3 Product 3", description: "Cat 3 Product 3 description", imageUrl: "img_"+"product3", price: 20, currency: "Euro"),
            // Category 4
            Product(id: 10, categoryId: 4, name: "Cat 4 Product 0", description: "Cat 4 Product 0 description", imageUrl: "img_"+"product0", price: 20, currency: "Euro"),
            Product(id: 11, categoryId: 4, name: "Cat 4 Product 1", description: "Cat 4 Product 1 description", imageUrl: "img_"+"product1", price: 10, currency: "Euro"),
            // Category 5
            Product(id: 10, categoryId: 5, name: "Cat 5 Product 0", description: "Cat 5 Product 0 description", imageUrl: "img_"+"product0", price: 20, currency: "Euro"),
            // Category 6
            Product(id: 10, categoryId: 6, name: "Cat 6 Product 0", description: "Cat 6 Product 0 description", imageUrl: "img_"+"product0", price: 20, currency: "Euro"),
            Product(id: 11, categoryId: 6, name: "Cat 6 Product 1", description: "Cat 6 Product 1 description", imageUrl: "img_"+"product1", price: 10, currency: "Euro"),
            // Category 7
            Product(id: 10, categoryId: 7, name: "Cat 7 Product 0", description: "Cat 7 Product 0 description", imageUrl: "img_"+"product0", price: 20, currency: "Euro"),
            Product(id: 11, categoryId: 7, name: "Cat 7 Product 1", description: "Cat 7 Product 1 description", imageUrl: "img_"+"product1", price: 10, currency: "Euro"),
            Product(id: 12, categoryId: 7, name: "Cat 7 Product 2", description: "Cat 7 Product 2 description", imageUrl: "img_"+"product2", price: 15, currency: "Euro"),
            // Category 8
            Product(id: 10, categoryId: 8, name: "Cat 8 Product 0", description: "Cat 8 Product 0 description", imageUrl: "img_"+"product0", price: 20, currency: "Euro"),
            Product(id: 11, categoryId: 8, name: "Cat 8 Product 1", description: "Cat 8 Product 1 description", imageUrl: "img_"+"product1", price: 10, currency: "Euro"),
            Product(id: 12, categoryId: 8, name: "Cat 8 Product 2", description: "Cat 8 Product 2 description", imageUrl: "img_"+"product2", price: 15, currency: "Euro"),
            Product(id: 13, categoryId: 8, name: "Cat 8 Product 3", description: "Cat 8 Product 3 description", imageUrl: "img_"+"product3", price: 20, currency: "Euro"),
            // Category 9
            Product(id: 10, categoryId: 9, name: "Cat 9 Product 0", description: "Cat 9 Product 0 description", imageUrl: "img_"+"product0", price: 20, currency: "Euro")
        ]
        self.products = products
    }
}
