//
//  ShoppingCartViewModelTests.swift
//  ShoppingAppTests
//
//  Created by Christian Slanzi on 29.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import XCTest
@testable import ShoppingApp

class ShoppingCartViewModelTests: XCTestCase {
    
    func testViewDidLoadLoadCart() {
        // given
        //let expectation = XCTestExpectation(description: "start callback called")
        
        let sut = makeSut()
        
        // when
        sut.inputs.viewDidLoad()

        // then
        XCTAssertEqual(sut.getElementsCount(), 2)
        
        // Wait until the expectation is fulfilled, with a timeout of 1 second.
        //wait(for: [expectation], timeout: TIMEOUT_1_SEC)

    }
    
    func testCallbackWhenDidTapOrderSummaryButton() {
        let expectation = XCTestExpectation(description: "start callback called")

        let sut = makeSut()
        sut.outputs.startOrderSummaryScreen = {
            // then
            expectation.fulfill()
        }
        // when
        
        sut.inputs.viewDidLoad()
        sut.inputs.didTapOrderSummaryButton()
        
        // Wait until the expectation is fulfilled, with a timeout of 1 second.
        wait(for: [expectation], timeout: TIMEOUT_1_SEC)
    }
    
    func testCallbackNotCalledWhenDidTapOrderSummaryButtonWithEmptyCart() {
        let expectation = XCTestExpectation(description: "start callback called")
        expectation.isInverted = true

        let sut = makeEmptySut()
        sut.outputs.startOrderSummaryScreen = {
            // then
            expectation.fulfill()
        }
        // when
        
        sut.inputs.viewDidLoad()
        sut.inputs.didTapOrderSummaryButton()
        
        // Wait until the expectation is fulfilled, with a timeout of 1 second.
        wait(for: [expectation], timeout: TIMEOUT_1_SEC)
    }
    
    func testCellViewModel() {
        let sut = makeSut()
        
        // when
        sut.inputs.viewDidLoad()
        let cellViewModel = sut.getCellViewModel(IndexPath(row: 1, section: 0))
        

        // then
        XCTAssertEqual(cellViewModel!.cartValue.id, 101)
    }
    
    func testDeleteElement() {
        let expectation = XCTestExpectation(description: "start callback called")
        let sut = makeSut()
        
        // when
        sut.inputs.viewDidLoad()
        sut.deleteElementAt(IndexPath(row: 1, section: 0)) { (result) in
            expectation.fulfill()
            
            // then
            XCTAssertEqual(sut.getElementsCount(), 1)
        }
    
        // Wait until the expectation is fulfilled, with a timeout of 1 second.
        wait(for: [expectation], timeout: TIMEOUT_1_SEC)
        
    }
    
    // MARK: - Helpers
    private func makeSut() -> ShoppingCartViewModel {
        Current = Environment.mock
        
        //make a cart with 2 elements
        Current.cartRepository.saveCartItem(CartItemDTO(productId: 100,quantity: 1))
        Current.cartRepository.saveCartItem(CartItemDTO(productId: 101,quantity: 2))
        
        let input = ShoppingCartViewModel.Input()
        let sut = ShoppingCartViewModel(input: input)
        return sut
    }
    
    private func makeEmptySut() -> ShoppingCartViewModel {
        Current = Environment.mock
           
           //make a cart with 2 elements
        Current.cartRepository.removeAllItems()
           
        let input = ShoppingCartViewModel.Input()
        let sut = ShoppingCartViewModel(input: input)
        return sut
    }
}
