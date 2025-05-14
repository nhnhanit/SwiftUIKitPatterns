//
//  SplashViewController.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 14/5/25.
//

import UIKit

final class SplashViewController: UIViewController {

    var onFinish: ((Bool) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        // Giả lập loading & check login
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            let isLoggedIn = false // TODO: kiểm tra token thực tế
            self.onFinish?(isLoggedIn)
        }
    }
}
