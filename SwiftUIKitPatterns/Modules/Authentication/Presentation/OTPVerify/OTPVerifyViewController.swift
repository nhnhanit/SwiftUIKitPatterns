//
//  OTPVerifyViewController.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 15/5/25.
//

import UIKit
import Combine

final class OTPVerifyViewController: UIViewController {
    private let viewModel: OTPVerifyViewModel

    private let phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        label.textColor = .label
        return label
    }()
    
    private let otpTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Input OTP"
        tf.keyboardType = .numberPad
        tf.borderStyle = .roundedRect
        return tf
    }()

    private let verifyButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Verify", for: .normal)
        btn.isEnabled = false
        return btn
    }()

    private var cancellables = Set<AnyCancellable>()

    init(viewModel: OTPVerifyViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "OTP Verify"
        view.backgroundColor = .systemBackground
        
        setupLayout()
        configureUI()
        bindViewModel()
        
#warning("hardcode for testing")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.otpTextField.text = "0000"
            self.verifyButton.isEnabled = true
        }
    }

    private func setupLayout() {
        let stack = UIStackView(arrangedSubviews: [phoneNumberLabel, otpTextField, verifyButton])
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])

        verifyButton.addTarget(self, action: #selector(didTapVerify), for: .touchUpInside)
    }
    
    private func configureUI() {
        phoneNumberLabel.text = "OTP sent to: \(viewModel.phoneNumber)"
    }

    private func bindViewModel() {
        // TODO: - validate text field and button
        
        otpTextField
            .publisher(for: \.text)
            .compactMap { $0 }
            .sink { [weak self] in self?.viewModel.otpCode = $0 }
            .store(in: &cancellables)
    }

    @objc private func didTapVerify() {
        viewModel.verifyOTP()
    }
}
