//
//  CartItemSummaryViewModel.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 14.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation
import CS_Common_Utils

protocol CartItemSummaryViewModelInputsType {
    func viewDidLoad()
    var addToCartClosure: BagClosure { get set }
}
protocol CartItemSummaryViewModelOutputsType: AnyObject {

}

protocol CartItemSummaryViewModelType {
    var inputs: CartItemSummaryViewModelInputsType { get }
    var outputs: CartItemSummaryViewModelOutputsType { get }
}

final class CartItemSummaryViewModel: CartItemSummaryViewModelType, CartItemSummaryViewModelInputsType, CartItemSummaryViewModelOutputsType {
    
    struct Input {
        //passing in data the viewModel needs from the view controller
        let cartItem: Observable<CartItemDTO>
    }
    
    struct Output {
        var name: Observable<String> = Observable("")
        var price: Observable<String> = Observable("")
        var quantity: Observable<String> = Observable("")
        var total: Observable<String> = Observable("")
    }
    
    var cartValue: CartValueViewModel
    
    private var input: Input
    public var output: Output
    
    init(input: Input) {
        self.input = input
        self.output = Output()
        self.cartValue = CartValueViewModel(id: input.cartItem.value.productId, stepValue: input.cartItem.value.quantity)
        bind()
    }
    
    var inputs: CartItemSummaryViewModelInputsType { return self }
    var outputs: CartItemSummaryViewModelOutputsType { return self }
    
    //input
    public func viewDidLoad() {
    }
    
    public var addToCartClosure: BagClosure = { _ in }
    

    //output

    // Binding
    private func bind() {
        guard let product = Current.dataManager.getProductFor(productId: input.cartItem.value.productId) else { return }
        
        self.input.cartItem.bind { [weak self] (element) in
            guard let self = self else { return }

            self.output.name = Observable(product.name)
            self.output.price = Observable("\(product.price) " + product.currency)

            self.output.quantity = Observable("\(element.quantity)")
            self.output.total = Observable("\(product.price * Double(element.quantity)) " + product.currency)
        }
        
        self.addToCartClosure = { [weak self] item in
            print(item)
            guard let self = self else { return }
            let itemDTO = CartItemDTO(productId: item.skuId, quantity: item.stepValue)
            Current.cartRepository.updateCartItem(itemDTO)
        }
    }
    
    // MARK: - Helpers

}
