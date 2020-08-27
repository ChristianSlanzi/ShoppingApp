//
//  CategoriesViewModelTests.swift
//  ShoppingAppTests
//
//  Created by Christian Slanzi on 10.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import XCTest
@testable import ShoppingApp

class CategoriesViewModelTests: XCTestCase {
        
    func testViewDidLoadLoadsCategories() {
        // given
        //let expectation = XCTestExpectation(description: "start callback called")
        
        let dataManager = AppDataManager.shared
        let sut = makeSut(dataManager: dataManager)
        
        // when
        sut.inputs.viewDidLoad()
        
        // then
        XCTAssertEqual(sut.getElementsCount(), dataManager.getAllCategoriesCount())
        
        // Wait until the expectation is fulfilled, with a timeout of 1 second.
        //wait(for: [expectation], timeout: TIMEOUT_1_SEC)

    }
    
    func testCacheCategoriesOrderSameAsFromDataManager() {
        let dataManager = AppDataManager.shared
        let sut = makeSut(dataManager: dataManager)
        
        // when
        sut.inputs.viewDidLoad()
        
        // then
        for index in 0..<dataManager.getAllCategoriesCount() {
            XCTAssertEqual(sut.getElementAt(IndexPath(row: index, section: 0)), dataManager.getCategoryAt(index: index))
        }
        
    }
    
    func testCategoryNotFoundIfIndexOutOfBounds() {
        let dataManager = AppDataManager.shared
        let sut = makeSut(dataManager: dataManager)
        
        // when
        sut.inputs.viewDidLoad()
        
        let numberOfCategories = dataManager.getAllCategoriesCount()
        //then
        XCTAssertEqual(sut.getElementAt(IndexPath(row: numberOfCategories, section: 0)), nil)
        XCTAssertEqual(sut.getElementAt(IndexPath(row: numberOfCategories+1, section: 0)), nil)
    }
    
    func testCallbackWithSelectedCategoryWhenDidTapCell() {
        let expectation = XCTestExpectation(description: "start callback called")
        let dataManager = AppDataManager.shared
        let numberOfCategories = dataManager.getAllCategoriesCount()
        let index = numberOfCategories - 1
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
    private func makeSut(dataManager: AppDataManager) -> CategoriesViewModel {
        let input = CategoriesViewModel.Input()
        let sut = CategoriesViewModel(input: input)
        return sut
    }
}
