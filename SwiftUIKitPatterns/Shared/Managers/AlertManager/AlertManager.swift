//
//  AlertManager.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 16/5/25.
//

import UIKit

final class AlertManager {

    static let shared = AlertManager()
    private var isPresenting = false
    private init() {}

    func show(type: AlertType, from viewController: UIViewController? = nil) {
        guard !isPresenting else { return }

        let alert = AlertBuilder.build(from: type) { [weak self] in
            self?.isPresenting = false
        }

        let presenter = viewController ?? Self.topViewController()
        guard let presenter else { return }

        isPresenting = true
        presenter.present(alert, animated: true)
    }

    private static func topViewController(base: UIViewController? = UIApplication.shared.connectedScenes
        .compactMap { $0 as? UIWindowScene }
        .flatMap { $0.windows }
        .first(where: { $0.isKeyWindow })?.rootViewController) -> UIViewController? {
        
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }

        if let tab = base as? UITabBarController,
           let selected = tab.selectedViewController {
            return topViewController(base: selected)
        }

        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }

        return base
    }
}
