//
//  CategoriesViewController.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 07.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit

final class CategoriesViewController: UIViewController {
    
    var viewModel: CategoriesViewModel
    
    var flowDelegate: ProductFlowControllerDelegate?
    
    var collectionView: UICollectionView!
    
    // MARK: - Viewcontroller Lifecycle
    
    init(viewModel: CategoriesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureCollectionView()
        bind()
        viewModel.viewDidLoad()
    }
    
    // MARK: - Layout Methods
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds,
                                          collectionViewLayout: CollectionViewHelper.createColumnedFlowLayout(in: view, numberOfColums: 1, itemHeight: 200)
        )
        
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(CategoryViewCell.self, forCellWithReuseIdentifier: CategoryViewCell.reuseID)
    }
    
    // MARK: - MVVM Binding
    private func bind() {
        viewModel.outputs.startElementTarget = { [weak self] category in
            guard let self = self else { return }
            self.flowDelegate?.startProductListFor(category: category)
        }
    }
}

// MARK: - Extensions (Delegation Conformance)

/// UICollectionViewDelegate Conformance
extension CategoriesViewController: UICollectionViewDelegate {
    
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryViewCell.reuseID, for: indexPath) as! CategoryViewCell
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

extension CategoriesViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
      return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = viewModel.getElementsCount()
        
        return count
    }
}
