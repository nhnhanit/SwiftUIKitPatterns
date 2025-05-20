//
//  OTPVerifyModuleBuilder.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 15/5/25.
//

import UIKit

final class OTPVerifyModuleBuilder {

    static func build(viewModel: OTPVerifyViewModel) -> UIViewController {
        let vc = OTPVerifyViewController(viewModel: viewModel)
        return vc
    }
}
