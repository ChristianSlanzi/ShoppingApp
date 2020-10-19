//
//  UICollectionView+Ext.swift
//  GitHubFollowers
//
//  Created by Christian Slanzi on 03.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit

//TODO: refactor the ui in a EmptyView class to set and use in this method
public extension UICollectionView {
    func setEmptyView(title: String, message: String) {
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        let titleLabel = UILabel()
        let messageLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        messageLabel.textColor = UIColor.lightGray
        messageLabel.font = UIFont(name: "HelveticaNeue-Regular", size: 17)
        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageLabel)
        titleLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        messageLabel.leftAnchor.constraint(equalTo: emptyView.leftAnchor, constant: 20).isActive = true
        messageLabel.rightAnchor.constraint(equalTo: emptyView.rightAnchor, constant: -20).isActive = true
        titleLabel.text = title
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        // The only tricky part is here:
        self.backgroundView = emptyView
    }
    func restore() {
        self.backgroundView = nil
    }
    
    /// overlay viewcontroller with an opaque layer to indicate loading state
    func showLoadingView() {
        let containerView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))

        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0

        UIView.animate(withDuration: 0.20) { containerView.alpha = 0.8 }

        let activityIndicatior = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicatior)

        activityIndicatior.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            activityIndicatior.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            activityIndicatior.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])

        activityIndicatior.startAnimating()
        
        // The only tricky part is here:
        self.backgroundView = containerView
    }
}

public extension UICollectionView {

  /// Generic function to dequeue cell
  func dequeue<Cell: UICollectionViewCell>(indexPath: IndexPath) -> Cell {
    // swiftlint:disable force_cast
    return dequeueReusableCell(withReuseIdentifier: String(describing: Cell.self), for: indexPath) as! Cell
  }

  /// Generic function to register cell
  func register(cellType: UICollectionViewCell.Type) {
    register(cellType, forCellWithReuseIdentifier: String(describing: cellType.self))
  }
}
