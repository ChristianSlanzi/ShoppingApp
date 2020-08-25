//
//  OrderIcon.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 25.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit

class OrderIcon: UIImageView {
    init(color: UIColor) {
        super.init(frame: .zero)
        image = UIImage(named: "icons-orders")?.withRenderingMode(.alwaysTemplate)
        contentMode = .scaleAspectFill
        backgroundColor = .clear
        tintColor = color
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
