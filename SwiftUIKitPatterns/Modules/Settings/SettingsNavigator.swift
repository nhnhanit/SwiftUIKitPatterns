//
//  SettingsNavigator.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 15/5/25.
//

protocol SettingsNavigator: AnyObject {
    func navigateToUserProfile()
    func logout()
    func showLogoutConfirmAlert(onConfirm: @escaping () -> Void)
}

extension MainTabCoordinator: SettingsNavigator {
    
    func navigateToUserProfile() {
        let userProfileVC = UserProfileViewController()
        self.settingsNav?.pushViewController(userProfileVC, animated: true)
    }
    
    func logout() {
        self.onLogout?()
    }
    
    func showLogoutConfirmAlert(onConfirm: @escaping () -> Void) {
        AlertManager.shared.show(type: .confirm(
            title: "Logout",
            message: "Are you sure you want to log out?",
            confirmTitle: "Log Out",
            cancelTitle: "Cancel",
            onConfirm: onConfirm
        ))
    }
}
