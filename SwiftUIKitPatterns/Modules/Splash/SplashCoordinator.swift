//
//  SplashCoordinator.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 16/5/25.
//

import UIKit

final class SplashCoordinator {
    var onFinish: ((Bool) -> Void)?

    func start() -> UIViewController {
        let vm = SplashViewModel()
        vm.onFinish = { [weak self] isLoggedIn in
            self?.onFinish?(isLoggedIn)
        }
        return SplashModuleBuilder.build(viewModel: vm)
    }
}
