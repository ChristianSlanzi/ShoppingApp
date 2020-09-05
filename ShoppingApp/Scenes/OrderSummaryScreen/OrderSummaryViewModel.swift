//
//  OrderSummaryViewModel.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 13.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation
import Utils

protocol OrderSummaryViewModelInputsType {
    func viewDidLoad()
    func didTapOrderDeliveryButton()
}
protocol OrderSummaryViewModelOutputsType: AnyObject {
    var reloadData: (() -> Void) { get set }
    var showOrderDeliveryScreen: (() -> Void) { get set }
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
    
    private var input: Input
    
    init(input: Input) {
        self.input = input
        //self.output = Output()
    }
    
    var inputs: OrderSummaryViewModelInputsType { return self }
    var outputs: OrderSummaryViewModelOutputsType { return self }
    
    //input
    public func viewDidLoad() {
        Current.analytics.track(.loadedScreen(screenName: "Order Summary"))
        Current.cartRepository.getAllCartItems(on: nil, completionHandler: { (items) in
            self.elements = items
        })
        self.outputs.reloadData()
    }
    
    public func didTapOrderDeliveryButton() {
        showOrderDeliveryScreen()
    }

    //output
    public var reloadData: (() -> Void) = { }
    public var showOrderDeliveryScreen: (() -> Void) = { }

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
        Observable(element)))
    }
    
}
