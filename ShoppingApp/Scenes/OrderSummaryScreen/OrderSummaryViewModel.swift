//
//  OrderSummaryViewModel.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 13.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

protocol OrderSummaryViewModelInputsType {
    func viewDidLoad()
}
protocol OrderSummaryViewModelOutputsType: AnyObject {
}

protocol OrderSummaryViewModelType {
    var inputs: OrderSummaryViewModelInputsType { get }
    var outputs: OrderSummaryViewModelOutputsType { get }
}

final class OrderSummaryViewModel: OrderSummaryViewModelType, OrderSummaryViewModelInputsType, OrderSummaryViewModelOutputsType {
    
    struct Input {
        //passing in data the viewModel needs from the view controller
    }
    
    struct Output {
        
    }
    
    private var input: Input
    
    init(input: Input) {
        self.input = input
    }
    
    var inputs: OrderSummaryViewModelInputsType { return self }
    var outputs: OrderSummaryViewModelOutputsType { return self }
    
    //input
    public func viewDidLoad() {
    }

    //output
    

    // MARK: - Helpers

    
}
