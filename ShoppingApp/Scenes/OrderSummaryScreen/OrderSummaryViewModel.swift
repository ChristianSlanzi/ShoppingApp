//
//  OrderSummaryViewModel.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 13.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation

protocol OrderSummaryViewModelInputsType {
    func viewDidLoad()
}
protocol OrderSummaryViewModelOutputsType: AnyObject {
    var reloadData: (() -> Void) { get set }
}

protocol OrderSummaryViewModelType {
    var inputs: OrderSummaryViewModelInputsType { get }
    var outputs: OrderSummaryViewModelOutputsType { get }
}

final class OrderSummaryViewModel: OrderSummaryViewModelType, OrderSummaryViewModelInputsType, OrderSummaryViewModelOutputsType {
    
    private var elements: [CartItemDTO] = []
    
    struct Input {
        //passing in data the viewModel needs from the view controller
    }
    
    struct Output {
        
    }
    
    let dataManager: AppDataManagement
    let cartRepository: CartRepositoryProtocol
    let orderRepository: OrderRepositoryProtocol
    
    private var input: Input
    
    init(input: Input, orderRepository: OrderRepositoryProtocol, cartRepository: CartRepositoryProtocol, dataManager: AppDataManagement) {
        self.input = input
        //self.output = Output()
        self.cartRepository = cartRepository
        self.orderRepository = orderRepository
        self.dataManager = dataManager
    }
    
    var inputs: OrderSummaryViewModelInputsType { return self }
    var outputs: OrderSummaryViewModelOutputsType { return self }
    
    //input
    public func viewDidLoad() {
        cartRepository.getAllCartItems(on: nil, completionHandler: { (items) in
            self.elements = items
        })
        self.outputs.reloadData()
    }

    //output
    public var reloadData: (() -> Void) = { }

    // MARK: - Helpers
    public func getElementsCount() -> Int {
        return elements.count
    }
    
    public func getElementAt(_ indexPath: IndexPath) -> CartItemDTO? {
        guard indexPath.row < elements.count else { return nil }
        return elements[indexPath.row]
    }
    
    public func getCellViewModel(_ indexPath: IndexPath) -> CartItemSummaryViewModel? {
        guard let element = getElementAt(indexPath) else { return nil }
        return CartItemSummaryViewModel(input: CartItemSummaryViewModel.Input(cartItem:
        Observable(element)), dataManager: dataManager, cartRepository: cartRepository)
    }
    
}
