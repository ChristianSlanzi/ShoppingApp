//
//  ProductFlowController.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 07.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit

protocol ProductFlowControllerDelegate: AnyObject {
    func startProductListFor(category: Category)
    func startProductDetailsFor(product: Product)
    
    func startOrderSummary()
}

final class ProductFlowController: UIViewController, FlowProtocol {
    
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
        /*
        let productListController = ProductListController(
          productNetworkingService: dependencyContainer.productNetworkingService
        )
        
        productListController.didSelectProduct = { [weak self] product in
          self?.showDetail(for: product)
        }
        
        embeddedNavigationController.viewControllers = [productListController]
        */
        let categoriesViewModel = CategoriesViewModel(input: CategoriesViewModel.Input(), dataManager: AppDataManager.shared
        )
        let categoriesViewController = CategoriesViewController(viewModel: categoriesViewModel)
        categoriesViewController.flowDelegate = self
        
        embeddedNavigationController.viewControllers = [categoriesViewController]
    }
}

extension ProductFlowController: ProductFlowControllerDelegate {
    func startProductListFor(category: Category) {
        let productsViewModel = ProductsViewModel(input: ProductsViewModel.Input(category: category), dataManager: AppDataManager.shared
        )
        let productsViewController = ProductsViewController(viewModel: productsViewModel)
        productsViewController.flowDelegate = self
        
        embeddedNavigationController.pushViewController(productsViewController, animated: true)
    }
    
    func startProductDetailsFor(product: Product) {
        let dbService = RealmDataManager(RealmProvider.default)
        let orderService = RealmDataManager(RealmProvider.main)
        
        let cartRepo = CartRepository(dbManager: dbService)
        let orderRepo = OrderRepository(dbManager: orderService)
        
        
        let productDetailsViewModel = ProductDetailsViewModel(input: ProductDetailsViewModel.Input(), element: product, orderRepository: orderRepo, cartRepository: cartRepo)
        let productDetailsViewController = ProductDetailsViewController(viewModel: productDetailsViewModel)
        productDetailsViewController.flowDelegate = self
        
        embeddedNavigationController.pushViewController(productDetailsViewController, animated: true)
    }
    
    func startOrderSummary() {
        parentFlowController.start()
    }
}
