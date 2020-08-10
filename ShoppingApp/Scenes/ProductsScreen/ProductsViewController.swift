//
//  ProductsViewController.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 08.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit

final class ProductsViewController: UIViewController {
    
    // MARK: - Viewcontroller Property
    
    var viewModel: ProductsViewModel
    
    // MARK: - FlowDelegate Property
    
    var flowDelegate: ProductFlowControllerDelegate?
    
    // MARK: - UI Properties
    
    var collectionView: UICollectionView!
    
    // MARK: - Viewcontroller Lifecycle
    
    init(viewModel: ProductsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        setupViews()
        setupConstraints()
        bind()
    }
    
    // MARK: - Layout Methods
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        title = "Products"
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds,
                                          collectionViewLayout: CollectionViewHelper.createColumnedFlowLayout(in: view, numberOfColums: 1, itemHeight: 200)
        )
        
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(ProductViewCell.self, forCellWithReuseIdentifier: ProductViewCell.reuseID)
    }
    
    private func setupConstraints() {
        
    }
    
    // MARK: - MVVM Binding
    
    private func bind() {
        viewModel.outputs.startElementTarget = { [weak self] product in
            guard let self = self else { return }
            self.flowDelegate?.startProductDetailsFor(product: product)
        }
    }
}

// MARK: - Extensions (Delegation Conformance)

/// UICollectionViewDelegate Conformance
extension ProductsViewController: UICollectionViewDelegate {
    
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductViewCell.reuseID, for: indexPath) as! ProductViewCell
        if let element = viewModel.getElementAt(indexPath) {
            cell.set(viewModel: element)
        }
        return cell
    }

    // handle user tap on follower list
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didTapCellAt(indexPath: indexPath)
    }
}

extension ProductsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
      return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = viewModel.getElementsCount()
        
        return count
    }
}
