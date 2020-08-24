//
//  OrderCellViewModel.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 23.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation

protocol OrderCellViewModelInputsType {
    func viewDidLoad()
}
protocol OrderCellViewModelOutputsType: AnyObject {

}

protocol OrderCellViewModelType {
    var inputs: OrderCellViewModelInputsType { get }
    var outputs: OrderCellViewModelOutputsType { get }
}

final class OrderCellViewModel: OrderCellViewModelType, OrderCellViewModelInputsType, OrderCellViewModelOutputsType {
    
    //private let cartRepository: CartRepositoryProtocol
    
    struct Input {
        //passing in data the viewModel needs from the view controller
        let order: Observable<OrderDTO>
    }
    
    struct Output {
        var id: Observable<String> = Observable("")
        var date: Observable<String> = Observable("")
    }
    
    //var cartValue: CartValueViewModel
    
    private var input: Input
    public var output: Output
    
    init(input: Input, dataManager: AppDataManagement) {
        self.input = input
        self.output = Output()
        //self.cartRepository = cartRepository
        bind()
    }
    
    var inputs: OrderCellViewModelInputsType { return self }
    var outputs: OrderCellViewModelOutputsType { return self }
    
    //input
    public func viewDidLoad() {
    }

    //output

    // Binding
    private func bind() {

        self.input.order.bind { [weak self] (element) in
            guard let self = self else { return }

            self.output.id = Observable(self.input.order.value.id)
            self.output.date = Observable(self.input.order.value.createdAt.description)

        }
        
    }
    
    // MARK: - Helpers

}
