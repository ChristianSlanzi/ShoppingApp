//
//  CustomScrollViewController.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 10.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit

class CustomScrollViewController: UIViewController {
    
    var bottomConstraint: NSLayoutConstraint?
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var scrollContentView: UIView = {
        let scrollView = UIView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    init() {
        //self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {

        view.addSubview(scrollView)
        scrollView.addSubview(scrollContentView)
        
    }
    
    @objc dynamic func setupConstraints() {
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            scrollContentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollContentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            scrollContentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            scrollContentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
        
        bottomConstraint = NSLayoutConstraint(item: scrollContentView, attribute: .bottom,
                                              relatedBy: .equal, toItem: scrollContentView,
                                              attribute: .bottom, multiplier: 1, constant: 0)
        scrollContentView.addConstraint(bottomConstraint!)
        
        scrollView.scrollIndicatorInsets = scrollView.contentInset
        
    }
    
    func addToContentView(_ views: UIView...) {
        for view in views { scrollContentView.addSubview(view) }
    }
    
    func getContentViewTopAnchor() -> NSLayoutYAxisAnchor {
        return scrollContentView.topAnchor
    }
    func getContentViewBottomAnchor() -> NSLayoutYAxisAnchor {
        return scrollContentView.bottomAnchor
    }
    func getContentViewLeadingAnchor() -> NSLayoutXAxisAnchor {
        return scrollContentView.leadingAnchor
    }
    func getContentViewTrailingAnchor() -> NSLayoutXAxisAnchor {
        return scrollContentView.trailingAnchor
    }
    
    func setContentViewBottom(view: UIView) {
        guard let bottomConstraint = bottomConstraint else { return }
        scrollContentView.removeConstraint(bottomConstraint)
        self.bottomConstraint = NSLayoutConstraint(item: view, attribute: .bottom,
        relatedBy: .equal, toItem: scrollContentView,
        attribute: .bottom, multiplier: 1, constant: -20)
        scrollContentView.addConstraint(self.bottomConstraint!)
        scrollContentView.setNeedsUpdateConstraints()
    }
}



