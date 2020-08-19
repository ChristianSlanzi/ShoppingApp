//
//  AppDataManager.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 08.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation

protocol AppDataManagement {
    func getAllCategoriesCount() -> Int
    func getAllCategories() -> [Category]
    func getCategoryAt(index: Int) -> Category?
    func getAllProductsCount() -> Int
    func getAllProducts() -> [Product]
    func getAllProductsCountFor(categoryId: Int) -> Int
    func getAllProductsFor(categoryId: Int) -> [Product]
    func getProductFor(productId: Int) -> Product?
}

class AppDataManager: AppDataManagement {

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
    
    public func getProductFor(productId: Int) -> Product? {
        return products.filter { (product) -> Bool in
            return product.id == productId
        }.first
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
            Product(id: 0, categoryId: 0, name: "Cat 0 Product 0", description: "Cat 0 Product 0 description", imageUrl: "clothes-sales", price: 20, currency: "Euro"),
            Product(id: 1, categoryId: 0, name: "Cat 0 Product 1", description: "Cat 0 Product 1 description", imageUrl: "pool-floaty-fun", price: 10, currency: "Euro"), 
            // Category 1
            Product(id: 10, categoryId: 1, name: "Cat 1 Product 0", description: "Cat 1 Product 0 description", imageUrl: "cafe-table-bath", price: 20, currency: "Euro"),
            Product(id: 11, categoryId: 1, name: "Cat 1 Product 1", description: "Cat 1 Product 1 description", imageUrl: "classic-tube", price: 10, currency: "Euro"),
            Product(id: 12, categoryId: 1, name: "Cat 1 Product 2", description: "Cat 1 Product 2 description\nthis is a long description that goes in multiple lines to demostrate the correctness of the dynamic auto layout constraints.", imageUrl: "rosa-bath", price: 15, currency: "Euro"),
            Product(id: 13, categoryId: 1, name: "Cat 1 Product 3", description: "Cat 1 Product 3 description", imageUrl: "shower-tube", price: 20, currency: "Euro"),
            // Category 2
            Product(id: 20, categoryId: 2, name: "Cat 2 Product 0", description: "Cat 2 Product 0 description", imageUrl: "dark-wall-bedside-table", price: 40, currency: "Euro"),
            Product(id: 21, categoryId: 2, name: "Cat 2 Product 1", description: "Cat 2 Product 1 description", imageUrl: "copper-light-in-bedroom", price: 20, currency: "Euro"),
            // Category 3
            Product(id: 30, categoryId: 3, name: "Cat 3 Product 0", description: "Cat 3 Product 0 description", imageUrl: "img_"+"product0", price: 20, currency: "Euro"),
            Product(id: 31, categoryId: 3, name: "Cat 3 Product 1", description: "Cat 3 Product 1 description", imageUrl: "img_"+"product1", price: 10, currency: "Euro"),
            Product(id: 32, categoryId: 3, name: "Cat 3 Product 2", description: "Cat 3 Product 2 description", imageUrl: "img_"+"product2", price: 15, currency: "Euro"),
            Product(id: 33, categoryId: 3, name: "Cat 3 Product 3", description: "Cat 3 Product 3 description", imageUrl: "img_"+"product3", price: 20, currency: "Euro"),
            // Category 4
            Product(id: 40, categoryId: 4, name: "Cat 4 Product 0", description: "Cat 4 Product 0 description", imageUrl: "img_"+"product0", price: 20, currency: "Euro"),
            Product(id: 41, categoryId: 4, name: "Cat 4 Product 1", description: "Cat 4 Product 1 description", imageUrl: "img_"+"product1", price: 10, currency: "Euro"),
            // Category 5
            Product(id: 50, categoryId: 5, name: "Cat 5 Product 0", description: "Cat 5 Product 0 description", imageUrl: "img_"+"product0", price: 20, currency: "Euro"),
            // Category 6
            Product(id: 60, categoryId: 6, name: "Cat 6 Product 0", description: "Cat 6 Product 0 description", imageUrl: "natural-wooden-dining", price: 20, currency: "Euro"),
            Product(id: 61, categoryId: 6, name: "Cat 6 Product 1", description: "Cat 6 Product 1 description", imageUrl: "img_"+"product1", price: 10, currency: "Euro"),
            // Category 7
            Product(id: 70, categoryId: 7, name: "Cat 7 Product 0", description: "Cat 7 Product 0 description", imageUrl: "img_"+"product0", price: 20, currency: "Euro"),
            Product(id: 71, categoryId: 7, name: "Cat 7 Product 1", description: "Cat 7 Product 1 description", imageUrl: "img_"+"product1", price: 10, currency: "Euro"),
            Product(id: 72, categoryId: 7, name: "Cat 7 Product 2", description: "Cat 7 Product 2 description", imageUrl: "img_"+"product2", price: 15, currency: "Euro"),
            // Category 8
            Product(id: 80, categoryId: 8, name: "Cat 8 Product 0", description: "Cat 8 Product 0 description", imageUrl: "img_"+"product0", price: 20, currency: "Euro"),
            Product(id: 81, categoryId: 8, name: "Cat 8 Product 1", description: "Cat 8 Product 1 description", imageUrl: "img_"+"product1", price: 10, currency: "Euro"),
            Product(id: 82, categoryId: 8, name: "Cat 8 Product 2", description: "Cat 8 Product 2 description", imageUrl: "img_"+"product2", price: 15, currency: "Euro"),
            Product(id: 83, categoryId: 8, name: "Cat 8 Product 3", description: "Cat 8 Product 3 description", imageUrl: "img_"+"product3", price: 20, currency: "Euro"),
            // Category 9
            Product(id: 90, categoryId: 9, name: "Cat 9 Product 0", description: "Cat 9 Product 0 description", imageUrl: "img_"+"product0", price: 20, currency: "Euro")
        ]
        self.products = products
    }
}
