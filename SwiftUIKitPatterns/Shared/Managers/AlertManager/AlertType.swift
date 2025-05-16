//
//  AlertType.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 16/5/25.
//

enum AlertType {
    case confirm(
        title: String,
        message: String?,
        confirmTitle: String,
        cancelTitle: String = "Cancel",
        onConfirm: () -> Void
    )
    
    case info(
        title: String,
        message: String?,
        dismissTitle: String = "OK"
    )
}
