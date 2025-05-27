//
//  PostNavigator.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 26/5/25.
//

protocol PostNavigator: AnyObject {
    func navigateToPostDetail(postId: Int, postsListVM: PostsListViewModel)
    func backToPostsList()
}

extension MainTabCoordinator: PostNavigator {
    
    func navigateToPostDetail(postId: Int, postsListVM: PostsListViewModel) {
        let networkService = DefaultNetworkService()
        
        let postRepository = DefaultPostRepository(network: networkService)
        let postUseCase = DefaultPostUseCase(repository: postRepository)
        
        let userRepository = DefaultUserRepository(network: networkService)
        let userUseCase = DefaultUserUseCase(repository: userRepository)
        
        let commentRepository = DefaultCommentRepository(network: networkService)
        let commentUseCase = DefaultCommentUseCase(repository: commentRepository)
        
        let postDetailVM = PostDetailViewModel(postId: postId,
                                               postUseCase: postUseCase,
                                               userUseCase: userUseCase,
                                               commentUseCase: commentUseCase,
                                               coordinator: self)
        
        let postDetailVC = PostDetailModuleBuilder.build(viewModel: postDetailVM)
        postDetailVC.hidesBottomBarWhenPushed = true
        
        postDetailVM.onFavorite = { post in
            await postsListVM.updatePost(post)
        }
        
//        postDetailVM.onDelete = { post in
//            postsListVM.removePost(postId: post.id)
//        }
        
        self.postsListNav?.pushViewController(postDetailVC, animated: true)
    }
    
    func backToPostsList() {
        Task {
            await MainActor.run {
                postsListNav?.popViewController(animated: true)
            }
        }
    }
}
