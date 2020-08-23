//
//  RealmDataManager.swift
//  Database
//
//  Created by Christian Slanzi on 26.03.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation
import RealmSwift

enum RealmError: Error {
    case eitherRealmIsNilOrNotRealmSpecificModel
}

extension RealmError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .eitherRealmIsNilOrNotRealmSpecificModel:
            return NSLocalizedString("eitherRealmIsNilOrNotRealmSpecificModel", comment: "eitherRealmIsNilOrNotRealmSpecificModel")
        }
    }
}

// MARK: - DataManager Implementation

class RealmDataManager {
    
    // MARK: - Stored Properties
    private let realm: Realm?
    
    init(_ realm: Realm?) {
        self.realm = realm
    }
}

extension RealmDataManager: DataManagement {
    // MARK: - Methods
    func create<T>(_ model: T.Type, completion: @escaping ((T) -> Void)) throws where T: Storable {
        guard let realm = realm, let model = model as? Object.Type else {
            throw RealmError.eitherRealmIsNilOrNotRealmSpecificModel
        }
        try realm.write {
            guard let newObject = realm.create(model, value: [], update: .error) as? T else { return }
            completion(newObject)
        }
    }
    
    func save(object: Storable) throws {
        guard let realm = realm, let object = object as? Object else {
            throw RealmError.eitherRealmIsNilOrNotRealmSpecificModel
        }
        try realm.write {
            realm.add(object, update: .all)
        }
    }
    
    func update(object: Storable) throws {
        guard let realm = realm, let object = object as? Object else {
            throw RealmError.eitherRealmIsNilOrNotRealmSpecificModel
        }
        try realm.write {
            realm.add(object, update: .all)
        }
    }
    
    func delete(object: Storable) throws {
        guard let realm = realm, let object = object as? Object else {
            throw RealmError.eitherRealmIsNilOrNotRealmSpecificModel
        }
        try realm.write {
            realm.delete(object)
        }
    }
    
    func deleteAll<T>(_ model: T.Type) throws where T: Storable {
        guard let realm = realm, let model = model as? Object.Type else {
            throw RealmError.eitherRealmIsNilOrNotRealmSpecificModel
        }
        try realm.write {
            let objects = realm.objects(model)
            for object in objects {
                realm.delete(object)
            }
        }
    }
    
    func fetch<T>(_ model: T.Type, predicate: NSPredicate?, sorted: Sorted?, completion: (([T]) -> Void)) where T: Storable {
        guard let realm = realm, let model = model as? Object.Type else {
            return
        }
        var objects = realm.objects(model)
        if let predicate = predicate {
            objects = objects.filter(predicate)
        }
        if let sorted = sorted {
            objects = objects.sorted(byKeyPath: sorted.key, ascending: sorted.ascending)
        }
        completion(objects.compactMap { $0 as? T })
    }
    
}
