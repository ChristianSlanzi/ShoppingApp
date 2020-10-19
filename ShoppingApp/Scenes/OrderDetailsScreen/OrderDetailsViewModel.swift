//
//  OrderDetailsViewModel.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 24.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation
import CS_Common_Utils

protocol OrderDetailsViewModelInputsType {
    func viewDidLoad()
}
protocol OrderDetailsViewModelOutputsType: AnyObject {
    var reloadData: (() -> Void) { get set }
}

protocol OrderDetailsViewModelType {
    var inputs: OrderDetailsViewModelInputsType { get }
    var outputs: OrderDetailsViewModelOutputsType { get }
}

final class OrderDetailsViewModel: OrderDetailsViewModelType, OrderDetailsViewModelInputsType, OrderDetailsViewModelOutputsType {
    
    private var element: Observable<OrderDTO>
    
    struct Input {
        //passing in data the viewModel needs from the view controller
    }
    
    struct Output {
        var id: Observable<String> = Observable("")
        var date: Observable<String> = Observable("")
    }
    
    private var input: Input
    public var output: Output
    
    init(input: Input, element: OrderDTO) {
        
        self.input = input
        self.output = Output()
        self.element = Observable(element)
        
        bind()
    }
    
    var inputs: OrderDetailsViewModelInputsType { return self }
    var outputs: OrderDetailsViewModelOutputsType { return self }
    
    //input
    public func viewDidLoad() {
        Current.analytics.track(.loadedScreen(screenName: "Order Details for order \(element.value.id)"))
    }
    
    //output
    public var reloadData: (() -> Void) = {}
    
    // Binding
    private func bind() {
        self.element.bind { [weak self] (element) in
            guard let self = self else { return }
            self.output.id = Observable(element.id)
            self.output.date = Observable(element.createdAt.toDayMonthYearTimeString())
        }
    }
    
    // MARK: - Helpers
    public func getElementsCount() -> Int {
        return element.value.items.count
    }
    
    public func getElementAt(_ indexPath: IndexPath) -> CartItemDTO? {
        let elements = element.value.items
        guard indexPath.row < elements.count else { return nil }
        return elements[indexPath.row]
    }
    
    public func getCellViewModel(_ indexPath: IndexPath) -> OrderItemCellViewModel? {
        guard let element = getElementAt(indexPath) else { return nil }
        return OrderItemCellViewModel(input: OrderItemCellViewModel.Input(cartItem:
            Observable(element)), dataManager: Current.dataManager, cartRepository: Current.cartRepository)
    }
}
