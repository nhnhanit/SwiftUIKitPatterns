//
//  AlertModel.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 20/5/25.
//


import UIKit

struct AlertModel {
    let title: String?
    let message: String?
    let actions: [AlertActionModel]

    init(title: String?, message: String?, actions: [AlertActionModel] = [.ok()]) {
        self.title = title
        self.message = message
        self.actions = actions
    }
}

struct AlertActionModel {
    let title: String
    let style: AlertActionStyle
    let handler: (() -> Void)?

    static func ok(handler: (() -> Void)? = nil) -> AlertActionModel {
        .init(title: "OK", style: .default, handler: handler)
    }

    static func cancel(handler: (() -> Void)? = nil) -> AlertActionModel {
        .init(title: "Cancel", style: .cancel, handler: handler)
    }
}

enum AlertActionStyle {
    case `default`, cancel, destructive

    func toUIAlertStyle() -> UIAlertAction.Style {
        switch self {
        case .default: return .default
        case .cancel: return .cancel
        case .destructive: return .destructive
        }
    }
}

