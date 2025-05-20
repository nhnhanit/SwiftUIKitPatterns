//
//  SettingsViewModel.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 14/5/25.
//

import Foundation

final class SettingsViewModel {
    private let navigator: SettingsNavigator
    
    init(navigator: SettingsNavigator) {
        self.navigator = navigator
    }
    
    func logoutButtonTapped() {
        let alertModel = AlertModel(title: "Confirm logout",
                                    message: "Are you sure you want to log out?",
                                    actions: [
                                        .init(title: "Log out", style: .default, handler: {
                                            
                                            // TODO: - Call API logout if need
                                            
                                            self.navigator.navigateLogout()
                                        }),
                                        .cancel()
                                    ])
        navigator.showLogoutConfirmAlert(alertModel: alertModel)
    }
    
    func profileButtonTapped() {
        navigator.navigateToUserProfile()
    }
}
