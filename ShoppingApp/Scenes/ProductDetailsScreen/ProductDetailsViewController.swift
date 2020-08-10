//
//  ProductDetailsViewController.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 10.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit

final class ProductDetailsViewController: CustomScrollViewController {
    
    // MARK: - Viewcontroller Property
    var viewModel: ProductDetailsViewModel
    
    // MARK: - FlowDelegate Property
    var flowDelegate: ProductFlowControllerDelegate?
    
    // MARK: - UI Properties
    var productImage: UIImageView!
    var productName: UILabel!
    var productPrice: UILabel!
    var productDescription: UILabel!
    var addToCartButton: UIButton!
    var orderNowButton: UIButton!
    
    // MARK: - Viewcontroller Lifecycle
    
    init(viewModel: ProductDetailsViewModel) {
        self.viewModel = viewModel
        super.init()
        bind()
        viewModel.viewDidLoad()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    // MARK: - Layout Methods
    internal override func setupViews() {
        super.setupViews()
        view.backgroundColor = .systemBackground
        
        productImage = UIImageView()
        productName = UILabel()
        productName.text = "Product name"
        productPrice = UILabel()
        productPrice.text = "Product price"
        productDescription = UILabel()
        productDescription.text = "Product description"
        addToCartButton = UIButton()
        addToCartButton.setTitle("Add to cart", for: .normal)
        orderNowButton = UIButton()
        orderNowButton.setTitle("Order now", for: .normal)
        
        productImage.backgroundColor = .systemTeal
        productName.backgroundColor = .systemYellow
        productPrice.backgroundColor = .systemYellow
        productDescription.backgroundColor = .systemYellow
        addToCartButton.backgroundColor = .blue
        orderNowButton.backgroundColor = .blue
        
        //productImage.image = UIImage(named: <#T##String#>)
        
        addToContentView(productImage,
                         productName,
                         productPrice,
                         productDescription,
                         addToCartButton,
                         orderNowButton
        )
    }
    
    internal override func setupConstraints() {
        super.setupConstraints()
        
        productImage.translatesAutoresizingMaskIntoConstraints = false
        productName.translatesAutoresizingMaskIntoConstraints = false
        productPrice.translatesAutoresizingMaskIntoConstraints = false
        productDescription.translatesAutoresizingMaskIntoConstraints = false
        addToCartButton.translatesAutoresizingMaskIntoConstraints = false
        orderNowButton.translatesAutoresizingMaskIntoConstraints = false
        
        let topAnchor = getContentViewTopAnchor()
        let leadingAnchor = getContentViewLeadingAnchor()
        let trailingAnchor = getContentViewTrailingAnchor()
        let bottomAnchor = getContentViewBottomAnchor()
        
        NSLayoutConstraint.activate([
            productImage.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            productImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            productImage.trailingAnchor
                .constraint(equalTo: trailingAnchor, constant: -20),
            productImage.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            productName.topAnchor.constraint(equalTo: productImage.bottomAnchor, constant: 20),
            productName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            productName.trailingAnchor
                .constraint(equalTo: trailingAnchor, constant: -20),
            productName.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            productPrice.topAnchor.constraint(equalTo: productName.bottomAnchor, constant: 20),
            productPrice.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            productPrice.trailingAnchor
                .constraint(equalTo: trailingAnchor, constant: -20),
            productPrice.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            productDescription.topAnchor.constraint(equalTo: productPrice.bottomAnchor, constant: 20),
            productDescription.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            productDescription.trailingAnchor
                .constraint(equalTo: trailingAnchor, constant: -20),
            productDescription.heightAnchor.constraint(equalToConstant: 250)
        ])
        
        NSLayoutConstraint.activate([
            addToCartButton.topAnchor.constraint(equalTo: productDescription.bottomAnchor, constant: 20),
            addToCartButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            addToCartButton.trailingAnchor
                .constraint(equalTo: trailingAnchor, constant: -20),
            addToCartButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            orderNowButton.topAnchor.constraint(equalTo: addToCartButton.bottomAnchor, constant: 20),
            orderNowButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            orderNowButton.trailingAnchor
                .constraint(equalTo: trailingAnchor, constant: -20),
            orderNowButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        setContentViewBottom(view: orderNowButton)
        
    }
    
    // MARK: - MVVM Binding
    private func bind() {
        //viewModel.outputs.
    }
}
