//
//  CustomScrollViewController.swift
//  CustomViews
//
//  Created by Christian Slanzi on 22.02.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit

public class CustomScrollViewController: BaseViewController {
    
    var bottomConstraint: NSLayoutConstraint?
    
    public var contentViews: [UIView] {
        return scrollContentView.subviews
    }
    
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
    
    override init() {
        //self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViews()
        setupConstraints()
    }
    
    public override func setupViews() {
        super.setupViews()
        view.addSubview(scrollView)
        scrollView.addSubview(scrollContentView)
        
    }
    
    @objc dynamic public override func setupConstraints() {
        super.setupConstraints()
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor),
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
    
    func setContentViewTopAnchor(_ anchor: NSLayoutYAxisAnchor) {
        NSLayoutConstraint.activate([scrollView.topAnchor.constraint(equalTo: anchor)])
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
    
    public func scrollRectToVisible(_ bounds: CGRect, animated: Bool) {
        self.scrollView.scrollRectToVisible(bounds, animated: true)
    }
    
    public func setContentInsets(_ insets: UIEdgeInsets) {
        scrollView.contentInset = insets
        scrollView.scrollIndicatorInsets = insets
    }
    
    //public func setContentScrollIndicatorInsets(_ insets: UIEdgeInsets) {
    //    scrollView.scrollIndicatorInsets = insets
    //}
    
}



