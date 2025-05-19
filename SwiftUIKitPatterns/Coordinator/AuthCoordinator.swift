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
        let networkService = DefaultNetworkService()
        let authRepository = DefaultAuthRepository(network: networkService)
        let authUseCase = DefaultAuthUseCase(repository: authRepository)

        let loginViewModel = LoginViewModel(authUseCase: authUseCase)
        loginViewModel.onPhoneSubmitted = { [weak self] phone in
            self?.navigateToOTP(for: phone)
        }
        
        let vc = LoginModuleBuilder.build(viewModel: loginViewModel)
        navigationController.setViewControllers([vc], animated: false)
        return navigationController
    }
    
    func navigateToOTP(for phone: String) {
        let vm = OTPVerifyViewModel(phoneNumber: phone)
        vm.onVerifySuccess = { [weak self] in
            self?.onFinish?()
        }
        
        let vc = OTPVerifyModuleBuilder.build(viewModel: vm)
        
        DispatchQueue.main.async { [weak self] in
            self?.navigationController.pushViewController(vc, animated: true)
        }
    }
    
}
