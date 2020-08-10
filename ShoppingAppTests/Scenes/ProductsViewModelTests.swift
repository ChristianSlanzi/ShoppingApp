//
//  ProductsViewModelTests.swift
//  ShoppingAppTests
//
//  Created by Christian Slanzi on 10.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation

import XCTest
@testable import ShoppingApp

class ProductsViewModelTests: XCTestCase {
        
    func testViewDidLoadLoadsProducts() {
        // given
        //let expectation = XCTestExpectation(description: "start callback called")
        
        let dataManager = AppDataManager.shared
        let sut = makeSut(dataManager: dataManager)
        
        // when
        sut.inputs.viewDidLoad()
        
        // then
        XCTAssertEqual(sut.getElementsCount(), dataManager.getAllProductsCount())
        
        // Wait until the expectation is fulfilled, with a timeout of 1 second.
        //wait(for: [expectation], timeout: TIMEOUT_1_SEC)

    }
    
    func testCacheProductsOrderSameAsFromDataManager() {
        let dataManager = AppDataManager.shared
        let sut = makeSut(dataManager: dataManager)
        
        // when
        sut.inputs.viewDidLoad()
        
        // then
        for index in 0..<dataManager.getAllProductsCount() {
            XCTAssertEqual(sut.getElementAt(IndexPath(row: index, section: 0)), dataManager.getProductAt(index: index))
        }
        
    }
    
    func testCategoryNotFoundIfIndexOutOfBounds() {
        let dataManager = AppDataManager.shared
        let sut = makeSut(dataManager: dataManager)
        
        // when
        sut.inputs.viewDidLoad()
        
        let numberOfProducts = dataManager.getAllProductsCount()
        //then
        XCTAssertEqual(sut.getElementAt(IndexPath(row: numberOfProducts, section: 0)), nil)
        XCTAssertEqual(sut.getElementAt(IndexPath(row: numberOfProducts+1, section: 0)), nil)
    }
    
    func testCallbackWithSelectedProductWhenDidTapCell() {
        let expectation = XCTestExpectation(description: "start callback called")
        let dataManager = AppDataManager.shared
        let numberOfProducts = dataManager.getAllProductsCount()
        let index = numberOfProducts - 1
        let indexPath = IndexPath(row: index, section: 0)
        
        let sut = makeSut(dataManager: dataManager)
        
        sut.outputs.startElementTarget = { [weak self] category in
            // then
            XCTAssertEqual(category, sut.getElementAt(indexPath))
            expectation.fulfill()
        }
        // when
        
        sut.inputs.viewDidLoad()
        sut.inputs.didTapCellAt(indexPath: indexPath)
        
        // Wait until the expectation is fulfilled, with a timeout of 1 second.
        wait(for: [expectation], timeout: TIMEOUT_1_SEC)
    }
    
    // MARK: - Helpers
    private func makeSut(dataManager: AppDataManager) -> ProductsViewModel {
        let input = ProductsViewModel.Input()
        let sut = ProductsViewModel(input: input, dataManager: dataManager)
        return sut
    }
}
