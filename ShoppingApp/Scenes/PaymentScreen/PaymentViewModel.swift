//
//  PaymentViewModel.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 17.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation

protocol PaymentViewModelInputsType {
    func viewDidLoad()
}
protocol PaymentViewModelOutputsType: AnyObject {
}

protocol PaymentViewModelType {
    var inputs: PaymentViewModelInputsType { get }
    var outputs: PaymentViewModelOutputsType { get }
}

final class PaymentViewModel: PaymentViewModelType, PaymentViewModelInputsType, PaymentViewModelOutputsType {
    
    struct Input {
        //passing in data the viewModel needs from the view controller
    }
    
    struct Output {
        
    }
    
    private var input: Input
    
    init(input: Input) {
        self.input = input
    }
    
    var inputs: PaymentViewModelInputsType { return self }
    var outputs: PaymentViewModelOutputsType { return self }
    
    //input
    public func viewDidLoad() {
    }

    //output
    
    // MARK: - Helpers
    

}
