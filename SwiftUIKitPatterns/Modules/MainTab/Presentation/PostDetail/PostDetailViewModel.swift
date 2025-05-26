//
//  PostDetailViewModel.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 26/5/25.
//

import Combine
final class PostDetailViewModel {
    @MainActor @Published private(set) var post: Post?
    @MainActor @Published private(set) var user: User?
    @MainActor @Published private(set) var comments: [Comment] = []

    private let postId: Int
    private let postUseCase: PostUseCase
    private let userUseCase: UserUseCase
    private let commentUseCase: CommentUseCase
    private let coordinator: PostNavigator

    init(postId: Int,
         postUseCase: PostUseCase,
         userUseCase: UserUseCase,
         commentUseCase: CommentUseCase,
         coordinator: PostNavigator) {
        self.postId = postId
        self.postUseCase = postUseCase
        self.userUseCase = userUseCase
        self.commentUseCase = commentUseCase
        self.coordinator = coordinator
    }
}
