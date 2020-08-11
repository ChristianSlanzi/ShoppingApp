//
//  MappableProtocol.swift
//  Database
//
//  Created by Christian Slanzi on 25.03.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation

// MARK: - MappableProtocol
protocol MappableProtocol {
    
    associatedtype PersistenceType: Storable
    
    // MARK: - Method
    func mapToPersistenceObject() -> PersistenceType
    static func mapFromPersistenceObject(_ object: PersistenceType) -> Self
    
}
