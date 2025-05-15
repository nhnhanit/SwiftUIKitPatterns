//
//  SettingsNavigator.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 15/5/25.
//

import UIKit

protocol SettingsNavigator: AnyObject {
    func navigateToUserProfile()
}

extension MainTabCoordinator: SettingsNavigator {
    func navigateToUserProfile() {
        let userProfileVC = UserProfileViewController()
        if let nav = self.tabBarController.selectedViewController as? UINavigationController {
            nav.pushViewController(userProfileVC, animated: true)
        } else {
            self.tabBarController.selectedViewController?.navigationController?.pushViewController(userProfileVC, animated: true)
        }
    }
}
