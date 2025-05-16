//
//  AlertBuilder.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 16/5/25.
//


import UIKit

final class AlertBuilder {
    private init() {}

    static func build(from alert: AlertType, onDismiss: (() -> Void)? = nil) -> UIAlertController {
        switch alert {
        case let .confirm(title, message, confirmTitle, cancelTitle, onConfirm):
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

            let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel) { _ in
                onDismiss?()
            }

            let confirmAction = UIAlertAction(title: confirmTitle, style: .destructive) { _ in
                onDismiss?()
                onConfirm()
            }

            alertController.addAction(cancelAction)
            alertController.addAction(confirmAction)
            return alertController

        case let .info(title, message, dismissTitle):
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

            let dismissAction = UIAlertAction(title: dismissTitle, style: .default) { _ in
                onDismiss?()
            }

            alertController.addAction(dismissAction)
            return alertController
        }
    }
}
