//
//  PostsListModuleBuilder.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 22/5/25.
//

import UIKit

final class PostsListModuleBuilder {

    static func build(viewModel: PostsListViewModel) -> UIViewController {
        let vc = PostsListViewController(viewModel: viewModel)
        return vc
    }
}
