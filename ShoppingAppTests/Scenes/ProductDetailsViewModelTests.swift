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
    
    // MARK: - Helpers
    private func makeSut(product: Product) -> ProductDetailsViewModel {
        let input = ProductDetailsViewModel.Input()
        let sut = ProductDetailsViewModel(input: input, element: product)
        return sut
    }
    
    private func makeTestProduct() -> Product {
        let product = Product(id: 0, name: "Test Product", description: "Test Product Description", imageUrl: "test-product-url", price: 10.0, currency: "Euro")
        return product
    }
}
