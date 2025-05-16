//
//  SplashModuleBuilder.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 16/5/25.
//

import UIKit

final class SplashModuleBuilder {

    static func build(viewModel: SplashViewModel) -> UIViewController {
        let vc = SplashViewController(viewModel: viewModel)
        return vc
    }
}
