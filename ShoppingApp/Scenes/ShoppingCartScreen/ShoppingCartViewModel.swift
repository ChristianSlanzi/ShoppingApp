//
//  ShoppingCartViewModel.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 10.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation
import CS_Common_Utils

protocol ShoppingCartViewModelInputsType {
    func viewDidLoad()
    func refreshData()
    func didTapOrderSummaryButton()
}
protocol ShoppingCartViewModelOutputsType: AnyObject {
    var reloadData: (() -> Void) { get set }
    var startOrderSummaryScreen: (() -> Void) { get set }
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
    
    private var input: Input
    public var output: Output
    
    init(input: Input) {
        self.input = input
        self.output = Output()
    }
    
    var inputs: ShoppingCartViewModelInputsType { return self }
    var outputs: ShoppingCartViewModelOutputsType { return self }
    
    //input
    public func viewDidLoad() {
        Current.analytics.track(.loadedScreen(screenName: "Shopping Cart"))
        refreshData()
    }
    
    public func refreshData() {
        Current.cartRepository.getAllCartItems(on: nil, completionHandler: { (items) in
            self.elements = items
            self.outputs.reloadData()
        })
    }
    
    public func didTapOrderSummaryButton() {
        guard elements.count > 0 else { return }
        startOrderSummaryScreen()
    }

    //output
    public var reloadData: (() -> Void) = { }
    public var startOrderSummaryScreen: (() -> Void) = { }
    
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
        Observable(element)))
    }
    
    public func deleteElementAt(_ indexPath: IndexPath, _ completion: @escaping (Result<Void, CartRepositoryError>)-> Void) {
        
        guard let element = getElementAt(indexPath) else { return } //TODO send a completion error
        
        Current.cartRepository.removeCartItemFor(productId: element.productId) { result in
            if result == true {
                elements.remove(at: indexPath.row)
                completion(.success(()))
                return
            }
            completion(.failure(.unableToDelete))
        }
    }
}
