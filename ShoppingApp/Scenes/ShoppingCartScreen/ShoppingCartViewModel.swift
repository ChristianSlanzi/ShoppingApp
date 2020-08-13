//
//  ShoppingCartViewModel.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 10.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation

protocol ShoppingCartViewModelInputsType {
    func viewDidLoad()
    func didTapOrderButton()
}
protocol ShoppingCartViewModelOutputsType: AnyObject {
    var reloadData: (() -> Void) { get set }
    var showOrderSummaryScreen: (() -> Void) { get set }
}

protocol ShoppingCartViewModelType {
    var inputs: ShoppingCartViewModelInputsType { get }
    var outputs: ShoppingCartViewModelOutputsType { get }
}

final class ShoppingCartViewModel: ShoppingCartViewModelType, ShoppingCartViewModelInputsType, ShoppingCartViewModelOutputsType {
    
    //private var elements: Observable<[Product]>
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
    public var output: Output
    
    init(input: Input, orderRepository: OrderRepositoryProtocol, cartRepository: CartRepositoryProtocol, dataManager: AppDataManagement) {
        self.input = input
        self.output = Output()
        self.cartRepository = cartRepository
        self.orderRepository = orderRepository
        self.dataManager = dataManager
    }
    
    var inputs: ShoppingCartViewModelInputsType { return self }
    var outputs: ShoppingCartViewModelOutputsType { return self }
    
    //input
    public func viewDidLoad() {
        cartRepository.getAllCartItems(on: nil, completionHandler: { (items) in
            self.elements = items
        })
        self.outputs.reloadData()
    }
    
    public func didTapOrderButton() {
        showOrderSummaryScreen()
    }

    //output
    public var reloadData: (() -> Void) = { }
    public var showOrderSummaryScreen: (() -> Void) = { }
    
    // MARK: - Helpers
    public func getElementsCount() -> Int {
        return elements.count
    }
    
    public func getElementAt(_ indexPath: IndexPath) -> CartItemDTO? {
        guard indexPath.row < elements.count else { return nil }
        return elements[indexPath.row]
    }
    
    public func getCellViewModel(_ indexPath: IndexPath) -> CartItemCellViewModel? {
        guard let element = getElementAt(indexPath) else { return nil }
        return CartItemCellViewModel(input: CartItemCellViewModel.Input(cartItem:
        Observable(element)), dataManager: dataManager, cartRepository: cartRepository)
    }
}
