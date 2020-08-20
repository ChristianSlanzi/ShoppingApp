//
//  DeliveryRepository.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 20.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import RealmSwift

// MARK: - DeliveryRepositoryProtocol
protocol DeliveryRepositoryProtocol {
    
    // MARK: - Methods
    func getDeliveryFor(phoneNumber: String, completionHandler: (DeliveryDTO?) -> Void)
    func getAllDeliverys(on sort: Sorted?, completionHandler: ([DeliveryDTO]) -> Void)
    func saveDelivery(delivery: DeliveryDTO)
    func updateDelivery(_ delivery: DeliveryDTO)
}

// MARK: - DeliveryRepository
class DeliveryRepository: BaseRepository<DeliveryDTO> {
    
}

// MARK: - DeliveryRepositoryProtocol implementation
extension DeliveryRepository: DeliveryRepositoryProtocol {
    func getDeliveryFor(phoneNumber: String, completionHandler: (DeliveryDTO?) -> Void) {
        super.fetch(DeliveryDAO.self, predicate: NSPredicate(format: "phoneNumber = '\(phoneNumber)'"), sorted: nil) { (deliveries) in
            completionHandler(deliveries.map { DeliveryDTO.mapFromPersistenceObject($0) }.first)
        }
    }
    
    // MARK: - Methods
    func getAllDeliverys(on sort: Sorted?, completionHandler: ([DeliveryDTO]) -> Void) {
        super.fetch(DeliveryDAO.self, predicate: nil, sorted: sort) { (deliveries) in
            completionHandler(deliveries.map { DeliveryDTO.mapFromPersistenceObject($0) })
        }
    }
    
    func saveDelivery(delivery: DeliveryDTO) {
        do {
            try super.save(object: delivery.mapToPersistenceObject())
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func updateDelivery(_ delivery: DeliveryDTO) {
        do {
            try super.update(object: delivery.mapToPersistenceObject())
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
