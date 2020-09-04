//
//  ProductDetailsViewModelTests.swift
//  ShoppingAppTests
//
//  Created by Christian Slanzi on 10.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import XCTest
@testable import ShoppingApp

class ProductDetailsViewModelTests: XCTestCase {
    
    func testOutputIsEqualToProductData() {
        // given
        let product = makeTestProduct()
        let sut = makeSut(product: product)
        
        // when
        sut.inputs.viewDidLoad()
        
        // then
        sut.output.name.bind { (name) in
            XCTAssertEqual(name, product.name)
        }
        sut.output.price.bind { (price) in
            XCTAssertEqual(price, "\(product.price) " + product.currency)
        }
        sut.output.description.bind { (description) in
            XCTAssertEqual(description, product.description)
        }
        sut.output.imageUrl.bind { (imageUrl) in
            XCTAssertEqual(imageUrl, product.imageUrl)
        }
    }
    
    func testAddProductToCart() {
        // given
        let expectation = XCTestExpectation(description: "callback called")
        let product = makeTestProduct()
        let sut = makeSut(product: product)
        
        // when
        sut.inputs.viewDidLoad()
        sut.inputs.didTapAddToCartButton()
        sut.inputs.didTapAddToCartButton()
        // then
        Current.cartRepository.getCartItemFor(productId: product.id) {  (item) in
            XCTAssertEqual(item?.quantity, 2)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: TIMEOUT_1_SEC)
    }
    
    func testDidTapOrderNowButtonCallbackCalled() {
        // given
        let expectation = XCTestExpectation(description: "callback called")
        let product = makeTestProduct()
        let sut = makeSut(product: product)
        
        // then
        sut.outputs.startOrderSummaryScreen = {
           expectation.fulfill()
        }
        
        // when
        sut.inputs.viewDidLoad()
        sut.inputs.didTapOrderNowButton()
        
        wait(for: [expectation], timeout: TIMEOUT_1_SEC)
    }
    
    // MARK: - Helpers
    private func makeSut(product: Product) -> ProductDetailsViewModel {
        
        Current = Environment.mock
        Current.cartRepository.removeAllItems()
        
        let input = ProductDetailsViewModel.Input()
        let sut = ProductDetailsViewModel(input: input, element: product)
        return sut
    }
    
    private func makeTestProduct() -> Product {
        let product = Product(id: 0, categoryId: 0, name: "Test Product", description: "Test Product Description", imageUrl: "test-product-url", price: 10.0, currency: "Euro")
        return product
    }

}

fileprivate class DummyOrderRepository: OrderRepositoryProtocol {
    // CRUD
    func saveOrder(_ order: OrderDTO) {}
    func getOrderFor(orderId: String, completionHandler: (OrderDTO?) -> Void) {}
    func getCartItemFor(productId: Int, completionHandler: (CartItemDTO?) -> Void) {}
    func getAllOrders(on sort: Sorted?, completionHandler: ([OrderDTO]) -> Void) {}
    func updateOrder(_ order: OrderDTO) {}
    func removeCartItemFor(productId: Int, completionHandler: (Bool) -> Void) {}
    func removeAllItems() {}
}

fileprivate class DummyCartRepository: CartRepositoryProtocol {
    // CRUD
    func saveCartItem(_ cartItem: CartItemDTO) {}
    func getCartItemFor(productId: Int, completionHandler: (CartItemDTO?) -> Void) {}
    func getAllCartItems(on sort: Sorted?, completionHandler: ([CartItemDTO]) -> Void) {}
    func updateCartItem(_ cartItem: CartItemDTO) {}
    func removeCartItemFor(productId: Int, completionHandler: (Bool) -> Void) {}
    func removeAllItems() {}
}
