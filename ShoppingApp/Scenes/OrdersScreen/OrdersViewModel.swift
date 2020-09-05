//
//  OrdersViewModel.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 23.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation
import Utils

protocol OrdersViewModelInputsType {
    func viewDidLoad()
    func didTapCellAt(indexPath: IndexPath)
}
protocol OrdersViewModelOutputsType: AnyObject {
    var reloadData: (() -> Void) { get set }
    var startElementTarget: ((OrderDTO) -> Void) { get set }
}

protocol OrdersViewModelType {
    var inputs: OrdersViewModelInputsType { get }
    var outputs: OrdersViewModelOutputsType { get }
}

final class OrdersViewModel: OrdersViewModelType, OrdersViewModelInputsType, OrdersViewModelOutputsType {

    private var elements: [OrderDTO] = []
    
    struct Input {
        //passing in data the viewModel needs from the view controller
    }
    
    struct Output {
        
    }
    
    private var input: Input
    
    init(input: Input) {
        self.input = input
    }
    
    var inputs: OrdersViewModelInputsType { return self }
    var outputs: OrdersViewModelOutputsType { return self }
    
    //input
    public func viewDidLoad() {
        Current.analytics.track(.loadedScreen(screenName: "Completed Orders"))
        Current.orderRepository.getAllOrders(on: nil, completionHandler: { [weak self] (orders) in
            guard let self = self else { return }
            self.elements = orders
            self.outputs.reloadData()
        })
    }
    
    public func didTapCellAt(indexPath: IndexPath) {
        if let element = getElementAt(indexPath) {
           startElementTarget(element)
        }
    }

    //output
    public var startElementTarget: ((OrderDTO) -> Void) = { _ in }
    public var reloadData: (() -> Void) = {}
    
    // MARK: - Helpers
    public func getElementsCount() -> Int {
        return elements.count
    }
    
    public func getElementAt(_ indexPath: IndexPath) -> OrderDTO? {
        guard indexPath.row < elements.count else { return nil }
        return elements[indexPath.row]
    }
    
    public func getCellViewModel(_ indexPath: IndexPath) -> OrderCellViewModel? {
        guard let element = getElementAt(indexPath) else { return nil }
        return OrderCellViewModel(input: OrderCellViewModel.Input(order:
        Observable(element)), dataManager: Current.dataManager)
    }
}
