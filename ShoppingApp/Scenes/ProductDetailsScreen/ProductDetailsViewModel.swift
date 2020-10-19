//
//  ProductDetailsViewModel.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 10.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation
import CS_Common_Utils

protocol ProductDetailsViewModelInputsType {
    func viewDidLoad()
    func didTapAddToCartButton()
    func didTapOrderNowButton()
}
protocol ProductDetailsViewModelOutputsType: AnyObject {
    var didAddElementToCart: ()->Void { get set }
    var startOrderSummaryScreen: (() -> Void) { get set }
}

protocol ProductDetailsViewModelType {
    var inputs: ProductDetailsViewModelInputsType { get }
    var outputs: ProductDetailsViewModelOutputsType { get }
}

final class ProductDetailsViewModel: ProductDetailsViewModelType, ProductDetailsViewModelInputsType, ProductDetailsViewModelOutputsType {
    
    private var element: Observable<Product>
    
    struct Input {
        //passing in data the viewModel needs from the view controller
    }
    
    struct Output {
        var name: Observable<String> = Observable("")
        var price: Observable<String> = Observable("")
        var description: Observable<String> = Observable("")
        var imageUrl: Observable<String> = Observable("")
    }
    
    private var input: Input
    public var output: Output
    
    init(input: Input, element: Product) {
        
        self.input = input
        self.output = Output()
        
        self.element = Observable(element)
        
        bind()
    }
    
    var inputs: ProductDetailsViewModelInputsType { return self }
    var outputs: ProductDetailsViewModelOutputsType { return self }
    
    //input
    public func viewDidLoad() {
        Current.analytics.track(.loadedScreen(screenName: "Product \(element.value.name)"))
    }
    
    public func didTapAddToCartButton() {
        addProductToCart()
    }
    
    public func didTapOrderNowButton() {
        addProductToCart()
        startOrderSummaryScreen()
    }

    //output
    public var didAddElementToCart: () -> Void = {}
    public var startOrderSummaryScreen: (() -> Void) = { }
    
    // Binding
    private func bind() {
       self.element.bind { [weak self] (element) in
            guard let self = self else { return }
            self.output.name = Observable(element.name)
            self.output.price = Observable("\(element.price) " + element.currency)
            self.output.description = Observable(element.description)
            self.output.imageUrl = Observable(element.imageUrl)
        }
    }
    
    // MARK: - Helpers
    private func addProductToCart() {
        let product = element.value
        Current.cartRepository.getCartItemFor(productId: product.id) { (item) in
            guard let item = item else {
                let itemDTO = CartItemDTO(productId: product.id, quantity: 1)
                Current.cartRepository.saveCartItem(itemDTO)
                didAddElementToCart()
                return
            }
            let itemDTO = CartItemDTO(productId: product.id, quantity: item.quantity + 1)
            Current.cartRepository.updateCartItem(itemDTO)
            didAddElementToCart()
        }
    }
}
