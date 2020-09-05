//
//  OrderResultViewModel.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 21.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation
import Utils

protocol OrderResultViewModelInputsType {
    func viewDidLoad()
    func didTapMainScreenButton()
}
protocol OrderResultViewModelOutputsType: AnyObject {
    var reloadData: (() -> Void) { get set }
    var showMainScreen: (() -> Void) { get set }
}

protocol OrderResultViewModelType {
    var inputs: OrderResultViewModelInputsType { get }
    var outputs: OrderResultViewModelOutputsType { get }
}

final class OrderResultViewModel: OrderResultViewModelType, OrderResultViewModelInputsType, OrderResultViewModelOutputsType {
    
    private var element: OrderDTO?
    private var elements: [CartItemDTO] = []
    
    struct Input {
        //passing in data the viewModel needs from the view controller
        var orderId: String
    }
    
    struct Output {
        
    }
    
    private var input: Input
    
    init(input: Input) {
        self.input = input
    }
    
    var inputs: OrderResultViewModelInputsType { return self }
    var outputs: OrderResultViewModelOutputsType { return self }
    
    //input
    public func viewDidLoad() {
        Current.analytics.track(.loadedScreen(screenName: "Order Result"))
        Current.orderRepository.getOrderFor(orderId: input.orderId, completionHandler: { (item) in
            self.element = item
            guard let elements = item?.items else { return }
            self.elements = elements
            self.outputs.reloadData()
        })
    }
    
    public func didTapMainScreenButton() {
        //TODO:

        // move to main screen?
        // outputs.showMainScreen()
    }

    //output
    public var reloadData: (() -> Void) = { }
    public var updateInvalidFields: (() -> Void) = { }
    public var showMainScreen: (() -> Void) = { }
    
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
