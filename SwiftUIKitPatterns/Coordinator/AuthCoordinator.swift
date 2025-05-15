//
//  AuthCoordinator.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 15/5/25.
//

import UIKit

final class AuthCoordinator {
    private let navigationController: UINavigationController

    var onAuthSuccess: (() -> Void)?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vm = LoginViewModel()
        vm.onPhoneSubmitted = { [weak self] phone in
//            self?.showOTP(for: phone)
            self?.onAuthSuccess?()
        }
        let vc = LoginModuleBuilder.build(viewModel: vm)
        navigationController.setViewControllers([vc], animated: false)
    }

    func showOTP(for phone: String) {
//        let vm = OTPVerifyViewModel(phoneNumber: phone)
//        vm.onVerified = { [weak self] in
//            self?.onAuthSuccess?() // gọi sang AppCoordinator
//        }
//        let vc = OTPVerifyViewController(viewModel: vm)
//        navigationController.pushViewController(vc, animated: true)
    }

}
