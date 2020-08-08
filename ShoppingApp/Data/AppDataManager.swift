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
    
    private init() {
        setupData()
    }
    
    // MARK: - PUBLIC METHODS
    public func getAllCategories() -> [Category] {
        return categories
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
    }
}
