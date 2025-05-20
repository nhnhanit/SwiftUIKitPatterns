//
//  LoadingDisplaying.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 20/5/25.
//

import UIKit
import ObjectiveC

private var loadingOverlayKey: UInt8 = 0

protocol LoadingDisplaying: AnyObject {
    func showLoadingIndicator()
    func hideLoadingIndicator()
}

extension UIViewController {
    
    private var loadingOverlay: UIView? {
        get { objc_getAssociatedObject(self, &loadingOverlayKey) as? UIView }
        set { objc_setAssociatedObject(self, &loadingOverlayKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    func showLoadingIndicator() {
        guard loadingOverlay == nil else { return }
        
        let overlay = UIView()
        overlay.translatesAutoresizingMaskIntoConstraints = false
        overlay.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        overlay.isUserInteractionEnabled = true

        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.startAnimating()
        
        overlay.addSubview(indicator)
        view.addSubview(overlay)

        // Constraints cho overlay
        NSLayoutConstraint.activate([
            overlay.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            overlay.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            overlay.topAnchor.constraint(equalTo: view.topAnchor),
            overlay.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        // Constraints cho indicator
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: overlay.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: overlay.centerYAnchor)
        ])
        
        // Lưu vào associated object
        self.loadingOverlay = overlay
    }

    func hideLoadingIndicator() {
        loadingOverlay?.removeFromSuperview()
        loadingOverlay = nil
    }
}

