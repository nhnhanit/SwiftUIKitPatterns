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
        loginViewModel.onRequestOTPSuccess = { [weak self] otpRespone in
            self?.navigateToOTP(for: otpRespone)
        }
        
        let vc = LoginModuleBuilder.build(viewModel: loginViewModel)
        navigationController.setViewControllers([vc], animated: false)
        return navigationController
    }
    
    func navigateToOTP(for otpRespone: OTPRespone) {
        let vm = OTPVerifyViewModel(otpRespone: otpRespone)
        vm.onVerifySuccess = { [weak self] in
            self?.onFinish?()
        }
        
        DispatchQueue.main.async { [weak self] in
            let vc = OTPVerifyModuleBuilder.build(viewModel: vm)
            self?.navigationController.pushViewController(vc, animated: true)
        }
    }
    
}
