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
        let viewModel = ShoppingCartViewModel(input: ShoppingCartViewModel.Input())
        let shoppingCartViewController = ShoppingCartViewController(viewModel: viewModel)
        shoppingCartViewController.flowDelegate = self
        embeddedNavigationController.viewControllers = [shoppingCartViewController]
    }
}

extension ShoppingCartFlowController: ShoppingCartFlowControllerDelegate {
    func startOrderSummary() {
        let viewModel = OrderSummaryViewModel(input: OrderSummaryViewModel.Input())
        let orderSummaryViewController = OrderSummaryViewController(viewModel: viewModel)
        orderSummaryViewController.flowDelegate = self
        embeddedNavigationController.pushViewController(orderSummaryViewController, animated: true)
    }
    
    func startOrderDelivery() {
        let viewModel = DeliveryViewModel(input: DeliveryViewModel.Input())
        let deliveryViewController = DeliveryViewController(viewModel: viewModel)
        deliveryViewController.flowDelegate = self
        embeddedNavigationController.pushViewController(deliveryViewController, animated: true)
    }
    
    func startPayment() {
        let viewModel = PaymentViewModel(input: PaymentViewModel.Input())
        let paymentViewController = PaymentViewController(viewModel: viewModel)
        paymentViewController.flowDelegate = self
        embeddedNavigationController.pushViewController(paymentViewController, animated: true)
    }
    
    func startOrderResult(with orderId: String) {
        let viewModel = OrderResultViewModel(input: OrderResultViewModel.Input(orderId: orderId))
        let orderResultViewController = OrderResultViewController(viewModel: viewModel)
        orderResultViewController.flowDelegate = self
        embeddedNavigationController.pushViewController(orderResultViewController, animated: true)
    }
    
    func backToMainScreen() {
        
    }
}
