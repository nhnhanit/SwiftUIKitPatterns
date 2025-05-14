//
//  AppCoordinator.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 14/5/25.
//

import UIKit

final class AppCoordinator {

    private let window: UIWindow
    private var navigationController: UINavigationController?

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        showSplash()
    }

    private func showSplash() {
        let splashVC = SplashViewController()
        splashVC.onFinish = { [weak self] isLoggedIn in
            if isLoggedIn {
                self?.showMain()
            } else {
                self?.showLogin()
            }
        }

        window.rootViewController = splashVC
        window.makeKeyAndVisible()
    }

    private func showLogin() {
        let loginVC = LoginViewController()
        loginVC.onLoginSuccess = { [weak self] in
            self?.showMain()
        }
        let nav = UINavigationController(rootViewController: loginVC)
        window.rootViewController = nav
    }

    private func showMain() {
        let tabBar = MainTabBarController()
        window.rootViewController = tabBar
    }
}
