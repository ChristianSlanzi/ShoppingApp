//
//  CategoriesViewModel.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 08.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation

protocol CategoriesViewModelInputsType {
    func viewDidLoad()
    func didTapCellAt(indexPath: IndexPath)
}
protocol CategoriesViewModelOutputsType: AnyObject {
}

protocol CategoriesViewModelType {
    var inputs: CategoriesViewModelInputsType { get }
    var outputs: CategoriesViewModelOutputsType { get }
}

final class CategoriesViewModel: CategoriesViewModelType, CategoriesViewModelInputsType, CategoriesViewModelOutputsType {
    
    private let dataManager: AppDataManager
    private var elements: [Category] = []
    
    struct Input {
        //passing in data the viewModel needs from the view controller
    }
    
    struct Output {
        
    }
    
    private var input: Input
    
    init(input: Input, dataManager: AppDataManager) {
        self.input = input
        self.dataManager = dataManager
    }
    
    var inputs: CategoriesViewModelInputsType { return self }
    var outputs: CategoriesViewModelOutputsType { return self }
    
    //input
    public func viewDidLoad() {
        elements = dataManager.getAllCategories()
    }
    
    public func didTapCellAt(indexPath: IndexPath) {
        if let element = getElementAt(indexPath) {
           //TODO
        }
    }


    //output

    
    // MARK: - Helpers
    public func getElementsCount() -> Int {
        return elements.count
    }
    
    public func getElementAt(_ indexPath: IndexPath) -> Category? {
        guard indexPath.row < elements.count else { return nil }
        return elements[indexPath.row]
    }
}
