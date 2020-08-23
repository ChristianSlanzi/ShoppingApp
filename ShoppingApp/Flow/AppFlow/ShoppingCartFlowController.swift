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
    func startPayment()
    func startOrderResult(with orderId: String)
    func backToMainScreen()
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
        let orderService = RealmDataManager(RealmProvider.main)
        
        let cartRepo = CartRepository(dbManager: dbService)
        let orderRepo = OrderRepository(dbManager: orderService)
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
        let orderService = RealmDataManager(RealmProvider.main)
        
        let cartRepo = CartRepository(dbManager: dbService)
        let orderRepo = OrderRepository(dbManager: orderService)
        let appDataManager = AppDataManager.shared
        let viewModel = OrderSummaryViewModel(input: OrderSummaryViewModel.Input(), orderRepository: orderRepo, cartRepository: cartRepo, dataManager: appDataManager)
        let orderSummaryViewController = OrderSummaryViewController(viewModel: viewModel)
        orderSummaryViewController.flowDelegate = self
        embeddedNavigationController.pushViewController(orderSummaryViewController, animated: true)
    }
    
    func startOrderDelivery() {
        let dbService = RealmDataManager(RealmProvider.default)
        let deliveryRepo = DeliveryRepository(dbManager: dbService)
        let viewModel = DeliveryViewModel(input: DeliveryViewModel.Input(), deliveryRepository: deliveryRepo)
        let deliveryViewController = DeliveryViewController(viewModel: viewModel)
        deliveryViewController.flowDelegate = self
        embeddedNavigationController.pushViewController(deliveryViewController, animated: true)
    }
    
    func startPayment() {
        let dbService = RealmDataManager(RealmProvider.default)
        let orderService = RealmDataManager(RealmProvider.main)
        
        let cartRepo = CartRepository(dbManager: dbService)
        let deliveryRepo = DeliveryRepository(dbManager: dbService)
        let orderRepo = OrderRepository(dbManager: orderService)
        
        let viewModel = PaymentViewModel(input: PaymentViewModel.Input(),
                                         cartRepository: cartRepo,
                                         deliveryRepository: deliveryRepo,
                                         orderRepository: orderRepo)
        let paymentViewController = PaymentViewController(viewModel: viewModel)
        paymentViewController.flowDelegate = self
        embeddedNavigationController.pushViewController(paymentViewController, animated: true)
    }
    
    func startOrderResult(with orderId: String) {
        let dbService = RealmDataManager(RealmProvider.default)
        let orderService = RealmDataManager(RealmProvider.main)
        
        let cartRepo = CartRepository(dbManager: dbService)
        let deliveryRepo = DeliveryRepository(dbManager: dbService)
        let orderRepo = OrderRepository(dbManager: orderService)
        let appDataManager = AppDataManager.shared
        
        let viewModel = OrderResultViewModel(input: OrderResultViewModel.Input(orderId: orderId),
                                             cartRepository: cartRepo,
                                             deliveryRepository: deliveryRepo,
                                             orderRepository: orderRepo,
                                             dataManager: appDataManager)
        let orderResultViewController = OrderResultViewController(viewModel: viewModel)
        orderResultViewController.flowDelegate = self
        embeddedNavigationController.pushViewController(orderResultViewController, animated: true)
    }
    
    func backToMainScreen() {
        
    }
}
