//
//  ShoppingCartFlowController.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 08.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit

protocol ShoppingCartFlowControllerDelegate: AnyObject {
    
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
        let orderRepo = OrderRepository(dbManager: dbService)
        let viewModel = ShoppingCartViewModel(input: ShoppingCartViewModel.Input(), orderRepository: orderRepo)
        let shoppingCartViewController = ShoppingCartViewController(viewModel: viewModel)
        embeddedNavigationController.viewControllers = [shoppingCartViewController]
    }
}

extension ShoppingCartFlowController: ShoppingCartFlowControllerDelegate {
    
}
