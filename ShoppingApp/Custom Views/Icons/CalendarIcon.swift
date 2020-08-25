//
//  CalendarIcon.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 25.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit

class CalendarIcon: UIImageView {
    init() {
        super.init(frame: .zero)
        image = UIImage(named: "icon-calendar")
        contentMode = .scaleAspectFill
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
