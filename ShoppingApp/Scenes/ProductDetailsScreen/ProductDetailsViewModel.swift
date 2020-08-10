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
}
protocol ProductDetailsViewModelOutputsType: AnyObject {
}

protocol ProductDetailsViewModelType {
    var inputs: ProductDetailsViewModelInputsType { get }
    var outputs: ProductDetailsViewModelOutputsType { get }
}

final class ProductDetailsViewModel: ProductDetailsViewModelType, ProductDetailsViewModelInputsType, ProductDetailsViewModelOutputsType {
    
    struct Input {
        //passing in data the viewModel needs from the view controller
    }
    
    struct Output {
        
    }
    
    private var input: Input
    
    init(input: Input) {
        self.input = input
    }
    
    var inputs: ProductDetailsViewModelInputsType { return self }
    var outputs: ProductDetailsViewModelOutputsType { return self }
    
    //input
    public func viewDidLoad() {
    }

    //output
    
    // MARK: - Helpers

}
