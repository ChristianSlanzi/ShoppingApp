//
//  ShoppingCartFlowController.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 08.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit

protocol ShoppingCartFlowControllerDelegate: AnyObject {
    func startOrderSummary()
    func startOrderDelivery()
}

final class ShoppingCartFlowController: UIViewController, FlowProtocol {
    
    private var embeddedNavigationController: UINavigationController!
    
    init() {
        super.init(nibName: nil, bundle: nil)

        embeddedNavigationController = UINavigationController()
        add(childController: embeddedNavigationController)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func start() {
        let dbService = RealmDataManager(RealmProvider.default)
        let cartRepo = CartRepository(dbManager: dbService)
        let orderRepo = OrderRepository(dbManager: dbService)
        let appDataManager = AppDataManager.shared
        let viewModel = ShoppingCartViewModel(input: ShoppingCartViewModel.Input(), orderRepository: orderRepo, cartRepository: cartRepo, dataManager: appDataManager)
        let shoppingCartViewController = ShoppingCartViewController(viewModel: viewModel)
        shoppingCartViewController.flowDelegate = self
        embeddedNavigationController.viewControllers = [shoppingCartViewController]
    }
}

extension ShoppingCartFlowController: ShoppingCartFlowControllerDelegate {
    func startOrderSummary() {
        let dbService = RealmDataManager(RealmProvider.default)
        let cartRepo = CartRepository(dbManager: dbService)
        let orderRepo = OrderRepository(dbManager: dbService)
        let appDataManager = AppDataManager.shared
        let viewModel = OrderSummaryViewModel(input: OrderSummaryViewModel.Input(), orderRepository: orderRepo, cartRepository: cartRepo, dataManager: appDataManager)
        let orderSummaryViewController = OrderSummaryViewController(viewModel: viewModel)
        orderSummaryViewController.flowDelegate = self
        embeddedNavigationController.pushViewController(orderSummaryViewController, animated: true)
    }
    
    func startOrderDelivery() {
        let viewModel = DeliveryViewModel(input: DeliveryViewModel.Input())
        let deliveryViewController = DeliveryViewController(viewModel: viewModel)
        embeddedNavigationController.pushViewController(deliveryViewController, animated: true)
    }
}
