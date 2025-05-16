//
//  AppRoot.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 15/5/25.
//

import UIKit

protocol AppRootProtocol {
    func resetToSplash()
}
extension AppRoot: AppRootProtocol {}

final class AppRoot {
    static let shared = AppRoot()
    
    private(set) var window: UIWindow?
    private(set) var appCoordinator: AppCoordinator?

    private init() {}

    func start(in window: UIWindow) {
        self.window = window
        let coordinator = AppCoordinator(window: window)
        self.appCoordinator = coordinator
        coordinator.start()
    }

    func resetToSplash() {
        appCoordinator?.resetToSplash()
    }

    func navigateToTab(_ tab: MainTab) {
        appCoordinator?.showMain(tab: tab)
    }
}
