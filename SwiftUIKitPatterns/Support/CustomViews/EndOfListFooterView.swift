//
//  EndOfListFooterView.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 23/5/25.
//

import UIKit

final class EndOfListFooterView: UIView {
    private let label: UILabel = {
        let label = UILabel()
        label.text = "You've reached the end."
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
