
//
//  ProductsViewModel.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 08.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation

protocol ProductsViewModelInputsType {
    func viewDidLoad()
    func didTapCellAt(indexPath: IndexPath)
}
protocol ProductsViewModelOutputsType: AnyObject {
    var startElementTarget: ((Product) -> Void) { get set }
}

protocol ProductsViewModelType {
    var inputs: ProductsViewModelInputsType { get }
    var outputs: ProductsViewModelOutputsType { get }
}

final class ProductsViewModel: ProductsViewModelType, ProductsViewModelInputsType, ProductsViewModelOutputsType {
    
    private var elements: [Product] = []
    
    struct Input {
        //passing in data the viewModel needs from the view controller
        let category: Category
    }
    
    struct Output {
        
    }
    
    private var input: Input
    
    init(input: Input) {
        self.input = input
    }
    
    var inputs: ProductsViewModelInputsType { return self }
    var outputs: ProductsViewModelOutputsType { return self }
    
    //input
    public func viewDidLoad() {
        elements = Current.dataManager.getAllProductsFor(categoryId: input.category.id)
    }
    
    public func didTapCellAt(indexPath: IndexPath) {
        if let element = getElementAt(indexPath) {
           startElementTarget(element)
        }
    }

    //output
    public var startElementTarget: ((Product) -> Void) = { _ in }
    
    // MARK: - Helpers
    public func getElementsCount() -> Int {
        return elements.count
    }
    
    public func getElementAt(_ indexPath: IndexPath) -> Product? {
        guard indexPath.row < elements.count else { return nil }
        return elements[indexPath.row]
    }
}
