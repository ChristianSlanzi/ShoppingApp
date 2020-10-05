//
//  ProductDetailsViewController.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 10.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit
import Utils
import Overture

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
        with(addToCartButton, secondaryButtonStyle)
        addToCartButton.setTitle("productinfo_addtocart_button".localized)
        
        orderNowButton = CustomButton()
        with(orderNowButton, primaryButtonStyle)
        orderNowButton.setTitle("productinfo_ordernow_button".localized)

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
        
        setContentViewTopAnchor(view.topAnchor)
        
        let topAnchor = getContentViewTopAnchor()
        let leadingAnchor = getContentViewLeadingAnchor()
        let trailingAnchor = getContentViewTrailingAnchor()
        //let bottomAnchor = getContentViewBottomAnchor()
        
        let margin: CGFloat = .grid_unit(6)
        let labelHeight: CGFloat = .grid_unit(8)
        let buttonHeight: CGFloat = .grid_unit(13)
            
        NSLayoutConstraint.activate([
            productImage.topAnchor.constraint(equalTo: topAnchor, constant: margin),
            productImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin),
            productImage.trailingAnchor
                .constraint(equalTo: trailingAnchor, constant: -margin),
            productImage.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            productName.topAnchor.constraint(equalTo: productImage.bottomAnchor, constant: margin),
            productName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin),
            productName.trailingAnchor
                .constraint(equalTo: trailingAnchor, constant: -margin),
            productName.heightAnchor.constraint(equalToConstant: labelHeight)
        ])
        
        NSLayoutConstraint.activate([
            productPrice.topAnchor.constraint(equalTo: productName.bottomAnchor, constant: margin),
            productPrice.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin),
            productPrice.trailingAnchor
                .constraint(equalTo: trailingAnchor, constant: -margin),
            productPrice.heightAnchor.constraint(equalToConstant: labelHeight)
        ])
        
        NSLayoutConstraint.activate([
            productDescription.topAnchor.constraint(equalTo: productPrice.bottomAnchor, constant: margin),
            productDescription.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin),
            productDescription.trailingAnchor
                .constraint(equalTo: trailingAnchor, constant: -margin),
            productDescription.heightAnchor.constraint(greaterThanOrEqualToConstant: labelHeight)
        ])
        
        NSLayoutConstraint.activate([
            addToCartButton.topAnchor.constraint(equalTo: productDescription.bottomAnchor, constant: margin),
            addToCartButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin),
            addToCartButton.trailingAnchor
                .constraint(equalTo: trailingAnchor, constant: -margin),
            addToCartButton.heightAnchor.constraint(equalToConstant: buttonHeight)
        ])
        
        NSLayoutConstraint.activate([
            orderNowButton.topAnchor.constraint(equalTo: addToCartButton.bottomAnchor, constant: margin),
            orderNowButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin),
            orderNowButton.trailingAnchor
                .constraint(equalTo: trailingAnchor, constant: -margin),
            orderNowButton.heightAnchor.constraint(equalToConstant: buttonHeight)
        ])
        
        setContentViewBottom(view: orderNowButton)
    }
    
    // MARK: - MVVM Binding
    private func bind() {
        
        // Input
        addToCartButton.didTouchUpInside = { (sender) in
            self.viewModel.inputs.didTapAddToCartButton()
        }
        orderNowButton.didTouchUpInside = { (sender) in
            self.viewModel.inputs.didTapOrderNowButton()
        }
        
        // Output
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
