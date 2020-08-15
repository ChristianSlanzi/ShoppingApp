//
//  DeliveryViewModel.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 15.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation

protocol DeliveryViewModelInputsType {
    func viewDidLoad()
}
protocol DeliveryViewModelOutputsType: AnyObject {
}

protocol DeliveryViewModelType {
    var inputs: DeliveryViewModelInputsType { get }
    var outputs: DeliveryViewModelOutputsType { get }
}

final class DeliveryViewModel: DeliveryViewModelType, DeliveryViewModelInputsType, DeliveryViewModelOutputsType {
    
    struct Input {
        //passing in data the viewModel needs from the view controller
    }
    
    struct Output {
        
    }
    
    private var input: Input
    
    init(input: Input) {
        self.input = input
    }
    
    var inputs: DeliveryViewModelInputsType { return self }
    var outputs: DeliveryViewModelOutputsType { return self }
    
    //input
    public func viewDidLoad() {
    }

    //output

    
    // MARK: - Helpers
    

}
