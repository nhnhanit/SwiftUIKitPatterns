//
//  PostDetailModuleBuilder.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 26/5/25.
//

import UIKit

final class PostDetailModuleBuilder {

    static func build(viewModel: PostDetailViewModel) -> UIViewController {
        let vc = PostDetailViewController(viewModel: viewModel)
        return vc
    }
}
