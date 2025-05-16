//
//  AuthCoordinator.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 15/5/25.
//

import UIKit

final class AuthCoordinator {
    
    var onFinish: (() -> Void)?
    
    private let navigationController = UINavigationController()
    
    func start() -> UIViewController {
        let vm = LoginViewModel()
        vm.onPhoneSubmitted = { [weak self] phone in
            self?.navigateToOTP(for: phone)
        }
        
        let vc = LoginModuleBuilder.build(viewModel: vm)
        navigationController.setViewControllers([vc], animated: false)
        return navigationController
    }
    
    func navigateToOTP(for phone: String) {
        let vm = OTPVerifyViewModel(phoneNumber: phone)
        vm.onVerifySuccess = { [weak self] in
            self?.onFinish?()
        }
        let vc = OTPVerifyModuleBuilder.build(viewModel: vm)
        navigationController.pushViewController(vc, animated: true)
    }
    
}
