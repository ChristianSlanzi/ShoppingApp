//
//  CartItemCellViewModel.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 12.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation

protocol CartItemCellViewModelInputsType {
    func viewDidLoad()
}
protocol CartItemCellViewModelOutputsType: AnyObject {

}

protocol CartItemCellViewModelType {
    var inputs: CartItemCellViewModelInputsType { get }
    var outputs: CartItemCellViewModelOutputsType { get }
}

final class CartItemCellViewModel: CartItemCellViewModelType, CartItemCellViewModelInputsType, CartItemCellViewModelOutputsType {
    
    private let dataManager: AppDataManagement
    
    struct Input {
        //passing in data the viewModel needs from the view controller
        let cartItem: Observable<CartItemDTO>
    }
    
    struct Output {
        var name: Observable<String> = Observable("")
        //var price: Observable<String> = Observable("")
        var imageUrl: Observable<String> = Observable("")
    }
    
    private var input: Input
    public var output: Output
    
    init(input: Input, dataManager: AppDataManagement) {
        self.input = input
        self.output = Output()
        self.dataManager = dataManager
        
        bind()
    }
    
    var inputs: CartItemCellViewModelInputsType { return self }
    var outputs: CartItemCellViewModelOutputsType { return self }
    
    //input
    public func viewDidLoad() {
    }
    

    //output

    // Binding
    private func bind() {
        guard let product = dataManager.getProductFor(productId: input.cartItem.value.productId) else { return }
        
        self.input.cartItem.bind { [weak self] (element) in
            guard let self = self else { return }

            self.output.name = Observable(product.name)
            //self.output.price = Observable("\(element.price) " + element.currency)

            self.output.imageUrl = Observable(product.imageUrl)
        }
    }
    
    // MARK: - Helpers

}
