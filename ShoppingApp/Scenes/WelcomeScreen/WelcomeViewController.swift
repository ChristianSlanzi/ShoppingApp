//
//  WelcomeViewController.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 06.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit

final class WelcomeViewController: UIViewController {

    // MARK: - Viewcontroller Property
    
    var viewModel: WelcomeViewModel
    
    // MARK: - FlowDelegate Property
    
    var flowDelegate: AppFlowControllerDelegate?
    
    // MARK: - UI Properties
    
    let welcomeLabel = UILabel(frame: .zero)
    let startButton = CustomButton()
    
    // MARK: - Viewcontroller Lifecycle
    
    init(viewModel: WelcomeViewModel) {
        self.viewModel = viewModel
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
        bind()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
       // DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
       //     self.flowDelegate?.welcomeControllerDidFinish(self)
       // }
    }
    
    // MARK: - Layout Methods
    
    private func setupViews() {
        view.backgroundColor = .white
        
        welcomeLabel.text = "welcome_label_title".localized
        
        startButton.set(backgroundColor: .systemGreen, title: "welcome_start_button".localized)
        startButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        view.addSubviews(welcomeLabel, startButton)
        
    }
    
    // MARK: - MVVM Binding
    
    @objc private func didTapButton(_ sender: Any) {
        viewModel.inputs.didTapStartButton()
    }
    
    private func bind() {
        viewModel.outputs.showMainScreen = {
            //guard let self = self else { return }
            self.flowDelegate?.welcomeControllerDidFinish(self)
        }
    }
}

// MARK: - UI Costraints

extension WelcomeViewController {
    private func setupConstraints() {
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            welcomeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            startButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            startButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            startButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            startButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
