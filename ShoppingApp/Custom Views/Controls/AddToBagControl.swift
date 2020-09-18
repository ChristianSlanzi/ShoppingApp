//
//  AddToBagControl.swift
//  CustomViews
//
//  Created by Christian Slanzi on 22.02.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation
import UIKit

// add a closure so that we send the step value to the controller
typealias BagClosure = ((skuId: Int, stepValue: Int)) -> ()

class AddToBagControl: UIControl, CustomViewProtocol {
    
    lazy var topStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .green
        stackView.axis = .vertical
        stackView.distribution = .fill
        return stackView
    }()
    
    lazy var bottomStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .red
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    lazy var addButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(hexString: "#225522")
        button.titleLabel?.font = .systemFont(ofSize: 12)
        button.addTarget(self, action: #selector(addToBag), for: .touchUpInside)
        return button
    }()
    
    lazy var plusButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(incrementButton), for: .touchUpInside)
        return button
    }()
    lazy var minusButton: UIButton = {
        let button = UIButton()
        button.setTitle("-", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(decrementButton(_:)), for: .touchUpInside)
        return button
    }()
    lazy var stepLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textAlignment = .center
        return label
    }()
    
    // MARK: INIT
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var viewModel: CartValueViewModel! {
        didSet {
            let isHidden = viewModel.showStepper
            //topStack.isHidden = isHidden
            //bottomStack.isHidden = !isHidden
            addButton.isHidden = isHidden
            plusButton.isHidden = !isHidden
            minusButton.isHidden = !isHidden
            stepLabel.isHidden = !isHidden
            stepLabel.text = "\(viewModel.stepValue)"
        }
    }
    
    var closure: BagClosure?
    
    // Methods
    
    func setupViews() {
        addSubview(topStack)
        topStack.addArrangedSubview(addButton)
        topStack.addArrangedSubview(bottomStack)
        bottomStack.addArrangedSubview(minusButton)
        bottomStack.addArrangedSubview(stepLabel)
        bottomStack.addArrangedSubview(plusButton)
    }
    
    func setupBehaviors() {
        
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
        topStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
        topStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
        topStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
        topStack.bottomAnchor.constraint(equalTo: bottomStack.topAnchor, constant: 0)
        ])
        NSLayoutConstraint.activate([
        //bottomStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
        bottomStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
        bottomStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
        bottomStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
    }
    
    func setupActions() {
        
    }
    
    @objc func addToBag(_ sender: Any) {
        viewModel = viewModel.onAddToBag()
        self.closure?((viewModel.id, viewModel.stepValue))
    }
    
    @objc func incrementButton(_ sender: Any) {
        viewModel = viewModel.onIncrement()
        self.closure?((viewModel.id, viewModel.stepValue))
    }
    
    @objc func decrementButton(_ sender: Any) {
        
        viewModel = viewModel.onDecrement()
        self.closure?((viewModel.id, viewModel.stepValue))
    }
    
    func configure(usingViewModel viewModel: CartValueViewModel, bagClosure: @escaping BagClosure ) -> Void {
        self.viewModel = viewModel
        self.addButton.setTitle(viewModel.title, for: .normal)
        self.closure = bagClosure
    }
}

// add a viewmodel permit to better test this control
struct CartValueViewModel {
    
    let id: Int
    let title: String
    let stepValue: Int
    let showStepper: Bool
    
    init(id: Int, stepValue: Int) {
        self.id = id
        self.title = "ADD TO BAG" //or overwrite it from outside
        self.stepValue = stepValue
        self.showStepper = stepValue > 0
    }
}

extension CartValueViewModel {
    
    func onAddToBag() -> CartValueViewModel {
        return CartValueViewModel(id: self.id, stepValue: 1)
    }
    
    func onIncrement() -> CartValueViewModel {
        guard stepValue < 10 else { return self }
        return CartValueViewModel(id: self.id, stepValue: self.stepValue + 1)
    }
    
    func onDecrement() -> CartValueViewModel {
        guard stepValue > 0 else { return self }
        return CartValueViewModel(id: self.id, stepValue: self.stepValue - 1)
    }
}
