//
//  LoginModuleBuilder.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 15/5/25.
//

import UIKit

final class LoginModuleBuilder {

    static func build(viewModel: LoginViewModel) -> UIViewController {
        let vc = LoginViewController(viewModel: viewModel)
        return vc
    }
}
