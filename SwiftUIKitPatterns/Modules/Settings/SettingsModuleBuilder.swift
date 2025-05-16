//
//  SettingsModuleBuilder.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 15/5/25.
//

import UIKit

final class SettingsModuleBuilder {

    static func build(navigator: SettingsNavigator) -> UIViewController {
        let viewModel = SettingsViewModel(navigator: navigator)
        let vc = SettingsViewController(viewModel: viewModel)
        vc.tabBarItem = UITabBarItem(title: "Settings", image: nil, tag: 1)
        return vc
    }
}
