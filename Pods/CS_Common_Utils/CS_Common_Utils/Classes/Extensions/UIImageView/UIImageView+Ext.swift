//
//  UIImageView+Ext.swift
//  GitHubFollowers
//
//  Created by Christian Slanzi on 26.07.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit

public extension UIImageView {
    @objc func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
