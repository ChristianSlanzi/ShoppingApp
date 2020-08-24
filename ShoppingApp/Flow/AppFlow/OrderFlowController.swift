//
//  OrderFlowController.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 23.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit

protocol OrderFlowControllerDelegate: AnyObject {
    func startOrderDetailsFor(order: OrderDTO)
}

final class OrderFlowController: UIViewController, FlowProtocol {
    
    private var parentFlowController: FlowProtocol
    private var embeddedNavigationController: UINavigationController!
    
    init(parent: FlowProtocol) {
        parentFlowController = parent
        super.init(nibName: nil, bundle: nil)

        embeddedNavigationController = UINavigationController()
        add(childController: embeddedNavigationController)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func start() {
        let orderService = RealmDataManager(RealmProvider.main)
        let orderRepo = OrderRepository(dbManager: orderService)
        
        let ordersViewModel = OrdersViewModel(input: OrdersViewModel.Input(), dataManager: AppDataManager.shared, orderRepository: orderRepo)
        
        let ordersViewController = OrdersViewController(viewModel: ordersViewModel)
        ordersViewController.flowDelegate = self
        
        embeddedNavigationController.viewControllers = [ordersViewController]
    }
}

extension OrderFlowController: OrderFlowControllerDelegate {
    
    func startOrderDetailsFor(order: OrderDTO) {
        let dbService = RealmDataManager(RealmProvider.default)
        let orderService = RealmDataManager(RealmProvider.main)
        
        let cartRepo = CartRepository(dbManager: dbService)
        let orderRepo = OrderRepository(dbManager: orderService)
        
        let orderDetailsViewModel = OrderDetailsViewModel(input: OrderDetailsViewModel.Input(),
                                                          element: order,
                                                          orderRepository: orderRepo, cartRepository:
            cartRepo, dataManager: AppDataManager.shared)
        let orderDetailsViewController = OrderDetailsViewController(viewModel: orderDetailsViewModel)
        orderDetailsViewController.flowDelegate = self
        
        embeddedNavigationController.pushViewController(orderDetailsViewController, animated: true)
    }
}
