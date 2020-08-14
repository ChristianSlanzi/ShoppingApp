//
//  ProductDetailsViewModel.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 10.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation

protocol ProductDetailsViewModelInputsType {
    func viewDidLoad()
    func didTapAddToCartButton()
    func didTapOrderNowButton()
}
protocol ProductDetailsViewModelOutputsType: AnyObject {
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
    
    let cartRepository: CartRepositoryProtocol
    let orderRepository: OrderRepositoryProtocol
    
    private var input: Input
    public var output: Output
    
    init(input: Input, element: Product, orderRepository: OrderRepositoryProtocol, cartRepository: CartRepositoryProtocol) {
        
        self.input = input
        self.output = Output()
        self.cartRepository = cartRepository
        self.orderRepository = orderRepository
        self.element = Observable(element)
        
        bind()
    }
    
    var inputs: ProductDetailsViewModelInputsType { return self }
    var outputs: ProductDetailsViewModelOutputsType { return self }
    
    //input
    public func viewDidLoad() {
    }
    
    public func didTapAddToCartButton() {
        let product = element.value
        cartRepository.getCartItemFor(productId: product.id) { (item) in
            guard let item = item else {
                let itemDTO = CartItemDTO(productId: product.id, quantity: 1)
                cartRepository.saveCartItem(itemDTO)
                return
            }
            let itemDTO = CartItemDTO(productId: product.id, quantity: item.quantity + 1)
            cartRepository.updateCartItem(itemDTO)
        }
    }
    
    public func didTapOrderNowButton() {
        //orderRepository.saveOrder(order: <#T##OrderDTO#>)
    }

    //output
    
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

}
