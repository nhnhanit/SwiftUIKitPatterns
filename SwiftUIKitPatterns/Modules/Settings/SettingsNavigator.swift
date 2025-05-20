//
//  SettingsNavigator.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 15/5/25.
//

protocol SettingsNavigator: AnyObject {
    func navigateToUserProfile()
    func navigateLogout()
    func showLogoutConfirmAlert(alertModel: AlertModel)
}

extension MainTabCoordinator: SettingsNavigator {
    
    func showLogoutConfirmAlert(alertModel: AlertModel) {
        AlertManager.shared.show(alertModel)
    }
    
    func navigateLogout() {
        self.onLogout?()
    }
    
    func navigateToUserProfile() {
        let userProfileVC = UserProfileViewController()
        self.settingsNav?.pushViewController(userProfileVC, animated: true)
    }
}
