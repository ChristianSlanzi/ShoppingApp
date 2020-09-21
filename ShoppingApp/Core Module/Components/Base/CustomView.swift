//
//  CustomView.swift
//  CustomViews
//
//  Created by Christian Slanzi on 22.02.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation
import UIKit

public protocol CustomViewProtocol {
    func setupViews()
    func setupBehaviors()
    func setupConstraints()
    func setupActions()
}

//TODO: create a protocol, extend the protocol with base implementation?, create base class
open class CustomView: UIView, CustomViewProtocol {
    
    // MARK: - ColorUpdatable
/*
    var theme: Theme = .light {
        didSet {
            guard oldValue != theme else { return }
            updateColors(for: theme)
        }
    }
*/
    public init() {
        super.init(frame: CGRect.zero)
        setupViews()
        setupConstraints()
        setupBehaviors()
        setupActions()
    }
    
    //initWithFrame to init view from code
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        setupBehaviors()
        setupActions()
    }
    
    //initWithCode to init view from xib or storyboard - Forbidden
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //custom views should override this to return true if
    //they cannot layout correctly using autoresizing.
    //from apple docs https://developer.apple.com/documentation/uikit/uiview/1622549-requiresconstraintbasedlayout
    override public class var requiresConstraintBasedLayout: Bool {
      return true
    }
    
    //common func to init our view
    open func setupViews() {
        
    }
    
    //common func to init behaviors, i.e. set delegates
    open func setupBehaviors() {
    }
    
    //common func to set autolayout constraints
    open func setupConstraints() {
    }
    
    //common func to set actions with targets and selectors
    open func setupActions() {
      //addButton.addTarget(self, action: #selector(moveHeaderView), for: .touchUpInside)
    }
}

// MARK: - ColorUpdatable
/*
extension CustomView {
    func updateColors(for theme: Theme) {
        backgroundColor = .contentBackground(for: theme)
    }
}
*/
