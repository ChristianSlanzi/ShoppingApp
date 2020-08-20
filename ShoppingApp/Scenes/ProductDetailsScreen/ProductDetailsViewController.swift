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
    var addToCartButton: CustomButton!
    var orderNowButton: CustomButton!
    
    // MARK: - Viewcontroller Lifecycle
    
    init(viewModel: ProductDetailsViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        bind()
        viewModel.viewDidLoad()
    }
    
    // MARK: - Layout Methods
    
    internal override func setupViews() {
        super.setupViews()
        view.backgroundColor = .systemBackground
        title = "productinfo_screen_title".localized
        
        productImage = UIImageView()
        productImage |> roundedStyle
        productImage.backgroundColor = .lightGray
        
        productName = UILabel()
        productName.text = "productinfo_product_placeholder".localized
        
        productName.backgroundColor = .white
        
        productPrice = UILabel()
        productPrice.text = "productinfo_price_placeholder".localized
        productPrice.backgroundColor = .white
        
        productDescription = UILabel()
        productDescription.numberOfLines = 0
        productDescription.text = "productinfo_description_placeholder".localized
        productDescription.backgroundColor = .white
        
        addToCartButton = CustomButton()
        addToCartButton.set(backgroundColor: .systemYellow, title: "productinfo_addtocart_button".localized)
        addToCartButton.addTarget(self, action: #selector(didTapAddToCartButton), for: .touchUpInside)
        
        orderNowButton = CustomButton()
        orderNowButton.set(backgroundColor: .systemGreen, title: "productinfo_ordernow_button".localized)
        orderNowButton.addTarget(self, action: #selector(didTapOrderNowButton), for: .touchUpInside)

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
        //let bottomAnchor = getContentViewBottomAnchor()
        
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
            productDescription.heightAnchor.constraint(greaterThanOrEqualToConstant: 30)
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
    @objc private func didTapAddToCartButton(_ sender: Any) {
        viewModel.inputs.didTapAddToCartButton()
    }
    
    @objc private func didTapOrderNowButton(_ sender: Any) {
        viewModel.inputs.didTapOrderNowButton()
    }
    
    private func bind() {
        viewModel.output.name.bind { [weak self] (name) in
            guard let self = self else { return }
            self.productName.text = name
        }
        viewModel.output.price.bind { [weak self] (price) in
            guard let self = self else { return }
            self.productPrice.text = price
        }
        viewModel.output.description.bind { [weak self] (description) in
            guard let self = self else { return }
            self.productDescription.text = description
        }
        viewModel.output.imageUrl.bind { [weak self] (imageUrl) in
            guard let self = self else { return }
            
            //TODO load the image... viewModel should not know about uikit
            // but it could load the image as Data
            // so the viewModel could do loading and caching using a service injected as Dependency.
            self.productImage.image = UIImage(named: imageUrl)
        }
        
        viewModel.outputs.didAddElementToCart = {
            self.presentAlertOnMainThread(title: "Cart", message: "Product was successfully added to cart", buttonTitle: "Ok")
        }
        
        viewModel.outputs.startOrderSummaryScreen = {
            self.flowDelegate?.startOrderSummary()
        }
    }
}
