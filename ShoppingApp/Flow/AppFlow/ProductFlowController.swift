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
}

final class ProductFlowController: UIViewController, FlowProtocol {
    
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
        let productsViewModel = ProductsViewModel(input: ProductsViewModel.Input(), dataManager: AppDataManager.shared
        )
        let productsViewController = ProductsViewController(viewModel: productsViewModel)
        productsViewController.flowDelegate = self
        
        embeddedNavigationController.pushViewController(productsViewController, animated: true)
    }
    
    func startProductDetailsFor(product: Product) {
        let productDetailsViewModel = ProductDetailsViewModel(input: ProductDetailsViewModel.Input(), element: product)
        let productDetailsViewController = ProductDetailsViewController(viewModel: productDetailsViewModel)
        productDetailsViewController.flowDelegate = self
        
        embeddedNavigationController.pushViewController(productDetailsViewController, animated: true)
    }
}
