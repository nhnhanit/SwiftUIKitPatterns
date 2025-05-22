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
        loginViewModel.onRequestOTPSuccess = { [weak self] otp in
            self?.navigateToOTP(for: otp.phone, otpExpiresIn: otp.otpExpiresIn)
        }
        
        let vc = LoginModuleBuilder.build(viewModel: loginViewModel)
        navigationController.setViewControllers([vc], animated: false)
        return navigationController
    }
    
    func navigateToOTP(for phoneNumber: String, otpExpiresIn: Int) {
        let vm = OTPVerifyViewModel(phoneNumber: phoneNumber, otpExpiresIn: otpExpiresIn)
        vm.onVerifySuccess = { [weak self] in
            self?.onFinish?()
        }
        
        DispatchQueue.main.async { [weak self] in
            let vc = OTPVerifyModuleBuilder.build(viewModel: vm)
            self?.navigationController.pushViewController(vc, animated: true)
        }
    }
    
}
