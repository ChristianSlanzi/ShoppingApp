//
//  CollectionViewHelper.swift
//  GitHubFollowers
//
//  Created by Christian Slanzi on 24.07.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit

/// a collection of utility functions to build collection views
public enum CollectionViewHelper {

    public static func createColumnedFlowLayout(in view: UIView, numberOfColums: Int, itemHeight: CGFloat) -> UICollectionViewFlowLayout {
        let width = view.bounds.width // screen width
        let padding: CGFloat = 12 // UIEdgeInsets
        let minimumItemSpacing: CGFloat = 10 // column width
        let availableWidth = width - (padding * 2) - (minimumItemSpacing * 2) // space available for cell content
        let itemWidth = availableWidth / CGFloat(numberOfColums) // column width

        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemHeight)

        return flowLayout
    }

}
