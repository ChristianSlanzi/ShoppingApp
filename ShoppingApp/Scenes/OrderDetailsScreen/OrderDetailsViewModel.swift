//
//  OrderDetailsViewModel.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 24.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation

protocol OrderDetailsViewModelInputsType {
    func viewDidLoad()
}
protocol OrderDetailsViewModelOutputsType: AnyObject {
}

protocol OrderDetailsViewModelType {
    var inputs: OrderDetailsViewModelInputsType { get }
    var outputs: OrderDetailsViewModelOutputsType { get }
}

final class OrderDetailsViewModel: OrderDetailsViewModelType, OrderDetailsViewModelInputsType, OrderDetailsViewModelOutputsType {
    
    private var element: Observable<OrderDTO>
    
    struct Input {
        //passing in data the viewModel needs from the view controller
    }
    
    struct Output {
        var id: Observable<String> = Observable("")
    }
    
    let orderRepository: OrderRepositoryProtocol
    
    private var input: Input
    public var output: Output
    
    init(input: Input, element: OrderDTO, orderRepository: OrderRepositoryProtocol) {
        
        self.input = input
        self.output = Output()
        self.orderRepository = orderRepository
        self.element = Observable(element)
        
        bind()
    }
    
    var inputs: OrderDetailsViewModelInputsType { return self }
    var outputs: OrderDetailsViewModelOutputsType { return self }
    
    //input
    public func viewDidLoad() {
    }
    
    //output
    
    
    // Binding
    private func bind() {
        self.element.bind { [weak self] (element) in
            guard let self = self else { return }
            self.output.id = Observable(element.id)
            
        }
    }
    
    // MARK: - Helpers
    
}
