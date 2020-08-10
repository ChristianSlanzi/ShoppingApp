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
    
    private var element: Observable<Product>
    
    struct Input {
        //passing in data the viewModel needs from the view controller
    }
    
    struct Output {
        var name: Observable<String> = Observable("")
        var price: Observable<String> = Observable("")
        var description: Observable<String> = Observable("")
        var imageUrl: Observable<String> = Observable("")
    }
    
    private var input: Input
    public var output: Output
    
    init(input: Input, element: Product) {
        self.input = input
        self.output = Output()
        self.element = Observable(element)
        self.element.bind { [weak self] (element) in
            guard let self = self else { return }
            self.output.name = Observable(element.name)
            self.output.price = Observable("\(element.price) " + element.currency)
            self.output.description = Observable(element.description)
            self.output.imageUrl = Observable(element.imageUrl)
        }
    }
    
    var inputs: ProductDetailsViewModelInputsType { return self }
    var outputs: ProductDetailsViewModelOutputsType { return self }
    
    //input
    public func viewDidLoad() {
    }

    //output
    
    // MARK: - Helpers

}
