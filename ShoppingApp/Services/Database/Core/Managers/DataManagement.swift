//
//  DataManagement.swift
//  Database
//
//  Created by Christian Slanzi on 25.03.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation

// MARK: - DataManager Protocol

protocol DataManagement {
    
    func create<T: Storable>(_ model: T.Type, completion: @escaping ((T) -> Void)) throws
    func save(object: Storable) throws
    func update(object: Storable) throws
    func delete(object: Storable) throws
    func deleteAll<T: Storable>(_ model: T.Type) throws
    func fetch<T: Storable>(_ model: T.Type, predicate: NSPredicate?, sorted: Sorted?, completion: (([T]) -> Void))
    
}
