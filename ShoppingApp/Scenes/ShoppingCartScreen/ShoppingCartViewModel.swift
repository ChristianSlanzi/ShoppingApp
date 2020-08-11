//
//  ShoppingCartViewModel.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 10.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation

protocol ShoppingCartViewModelInputsType {
    func viewDidLoad()
}
protocol ShoppingCartViewModelOutputsType: AnyObject {
}

protocol ShoppingCartViewModelType {
    var inputs: ShoppingCartViewModelInputsType { get }
    var outputs: ShoppingCartViewModelOutputsType { get }
}

final class ShoppingCartViewModel: ShoppingCartViewModelType, ShoppingCartViewModelInputsType, ShoppingCartViewModelOutputsType {
    
    //private var elements: Observable<[Product]>
    
    struct Input {
        //passing in data the viewModel needs from the view controller
    }
    
    struct Output {

    }
    
    let orderRepository: OrderRepositoryProtocol
    
    private var input: Input
    public var output: Output
    
    init(input: Input, orderRepository: OrderRepositoryProtocol) {
        self.input = input
        self.output = Output()
        self.orderRepository = orderRepository
    }
    
    var inputs: ShoppingCartViewModelInputsType { return self }
    var outputs: ShoppingCartViewModelOutputsType { return self }
    
    //input
    public func viewDidLoad() {
    }

    //output
    
    // MARK: - Helpers

}
