//
//  OrderItemCellViewModel.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 12.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation

protocol OrderItemCellViewModelInputsType {
    func viewDidLoad()
    var addToOrderClosure: BagClosure { get set }
}
protocol OrderItemCellViewModelOutputsType: AnyObject {

}

protocol OrderItemCellViewModelType {
    var inputs: OrderItemCellViewModelInputsType { get }
    var outputs: OrderItemCellViewModelOutputsType { get }
}

final class OrderItemCellViewModel: OrderItemCellViewModelType, OrderItemCellViewModelInputsType, OrderItemCellViewModelOutputsType {
    
    private let dataManager: AppDataManagement
    private let cartRepository: CartRepositoryProtocol
    
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
    
    init(input: Input, dataManager: AppDataManagement, cartRepository: CartRepositoryProtocol) {
        self.input = input
        self.output = Output()
        self.dataManager = dataManager
        self.cartRepository = cartRepository

        bind()
    }
    
    var inputs: OrderItemCellViewModelInputsType { return self }
    var outputs: OrderItemCellViewModelOutputsType { return self }
    
    //input
    public func viewDidLoad() {
    }
    
    public var addToOrderClosure: BagClosure = { _ in }
    

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
