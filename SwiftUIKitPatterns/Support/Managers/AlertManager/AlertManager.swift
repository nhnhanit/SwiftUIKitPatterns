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
    private var alertQueue: [AlertModel] = []
    private init() {}

    func show(_ model: AlertModel, from viewController: UIViewController? = nil) {
        let presenter = viewController ?? Self.topViewController()
        guard let presenter else { return }

        alertQueue.append(model)
        showNextIfNeeded(from: presenter)
    }

    private func showNextIfNeeded(from presenter: UIViewController) {
        guard !isPresenting, !alertQueue.isEmpty else { return }

        isPresenting = true
        let nextModel = alertQueue.removeFirst()

        let alert = UIAlertController(title: nextModel.title, message: nextModel.message, preferredStyle: .alert)

        for action in nextModel.actions {
            let alertAction = UIAlertAction(title: action.title, style: action.style.toUIAlertStyle()) { [weak self] _ in
                action.handler?()
                self?.isPresenting = false
                self?.showNextIfNeeded(from: presenter)
            }
            alert.addAction(alertAction)
        }

        DispatchQueue.main.async { [weak self, weak presenter] in
            guard let self = self, let presenter = presenter, presenter.view.window != nil else {
                self?.isPresenting = false
                if let fallbackPresenter = Self.topViewController() {
                    self?.showNextIfNeeded(from: fallbackPresenter)
                }
                return
            }

            presenter.present(alert, animated: true)
        }
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
