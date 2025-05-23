//
//  LoginViewController.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 14/5/25.
//

import UIKit
import Combine

final class LoginViewController: UIViewController {
    private let viewModel: LoginViewModel
    
    private let phoneTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Input phone number"
        tf.keyboardType = .phonePad
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    private let continueButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Continue", for: .normal)
        btn.isEnabled = false
        return btn
    }()
    
    private var cancellables = Set<AnyCancellable>()
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "login"
        view.backgroundColor = .systemBackground
        setupLayout()
        configureUI()
        bindViewModel()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.phoneTextField.text = "0909009009"
            self.continueButton.isEnabled = true
        }
    }
    
    private func setupLayout() {
        let stack = UIStackView(arrangedSubviews: [phoneTextField, continueButton])
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
        
        continueButton.addTarget(self, action: #selector(didTapContinueButton), for: .touchUpInside)
    }
    
    private func configureUI() { }
    
    private func bindViewModel() {
        // TODO: - validate text field and button
        
        phoneTextField
            .publisher(for: \.text)
            .compactMap { $0 }
            .sink { [weak self] in
                guard let self = self else { return }
                
                self.viewModel.phoneNumber = $0
            }
            .store(in: &cancellables)
        
        viewModel.$isLoading
            .receive(on: RunLoop.main)
            .sink { [weak self] isLoading in
                guard let self = self else { return }
                
                isLoading ? self.showLoadingIndicator() : self.hideLoadingIndicator()
            }
            .store(in: &cancellables)
        
        viewModel.onShowAlert = { [weak self] alertModel in
            guard let self = self else { return }
            
            AlertManager.shared.show(alertModel, from: self)
        }
        
    }
    
    @objc private func didTapContinueButton() {
        Task {
            await viewModel.continueButtonTapped()
        }
    }
    
}

