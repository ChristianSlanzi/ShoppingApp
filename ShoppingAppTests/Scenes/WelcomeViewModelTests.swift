//
//  WelcomeViewModelTests.swift
//  ShoppingAppTests
//
//  Created by Christian Slanzi on 10.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import XCTest
@testable import ShoppingApp

class WelcomeViewModelTests: XCTestCase {
    
    let TIMEOUT_1_SEC = 1.0
    
    func testCallbackWhenDidTapStartButton() {
        // given
        let expectation = XCTestExpectation(description: "start callback called")
        
        let sut = makeSut()
        sut.outputs.showMainScreen = {
            // then
            expectation.fulfill()
        }
        
        // when
        sut.inputs.viewDidLoad()
        sut.inputs.didTapStartButton()
        
        // Wait until the expectation is fulfilled, with a timeout of 2 seconds.
        wait(for: [expectation], timeout: TIMEOUT_1_SEC)

    }
    
    // MARK: - Helpers
    private func makeSut() -> WelcomeViewModel {
        let input = WelcomeViewModel.Input()
        let sut = WelcomeViewModel(input: input)
        return sut
    }
}
