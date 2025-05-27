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
    @MainActor @Published private(set) var isLoading: Bool = false        // loading first time
    var onShowAlert: ((AlertModel) -> Void)?
    var onFavorite: ((Post) async -> Void)?
    var onDelete: ((Post) -> Void)?
    
    private let postId: Int
    private let postUseCase: PostUseCase
    private let userUseCase: UserUseCase
    private let commentUseCase: CommentUseCase
    let coordinator: PostNavigator
    
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
    
    func loadData() async {
        // Prevent duplicate loading
        guard await !isLoading else { return }
        
        await MainActor.run {
            isLoading = true
        }
        
        let postTask = Task {
            try await postUseCase.loadPostDetail(postId: postId)
        }
        let commentsTask = Task {
            try await commentUseCase.loadCommentsList(postId: postId, start: 0, limit: 20)
        }
        
        async let handleCommentsTask: () = handleComments(commentsTask)
        async let handlePostAndUserTask: () = handlePostAndUser(postTask)
        
        // Wait for both to complete
        _ = await (handleCommentsTask, handlePostAndUserTask)
        
        // Reset loading state
        await MainActor.run {
            isLoading = false
        }
    }
    
    private func handleComments(_ task: Task<[Comment], Error>) async {
        do {
            let comments = try await task.value
            await MainActor.run {
                self.comments = comments
            }
        } catch {
            onShowAlert?(AlertModel(title: "Error", message: error.localizedDescription))

        }
    }
    
    private func handlePostAndUser(_ task: Task<Post, Error>) async {
        do {
            let post = try await task.value
            await MainActor.run {
                self.post = post
            }
            let user = try await userUseCase.loadUserDetail(userId: post.userId)
            await MainActor.run {
                self.user = user
            }
        } catch {
            onShowAlert?(AlertModel(title: "Error", message: error.localizedDescription))
        }
    }
    
    func favoriteButtonTapped() {
        Task {
            guard let post = await self.post else { return }
            let newValue = !post.isFavorite
            
            if let updatedPost = await updateFavorite(postId: post.id, isFavorite: newValue) {
                await updatePost(updatedPost)
                await self.onFavorite?(updatedPost) // Call back to Update UI on PostsList
            }
        }
    }
    
    func updateFavorite(postId: Int, isFavorite: Bool) async -> Post? {
        do {
            let updatedPost = try await postUseCase.updatePost(postId: postId, isFavorite: isFavorite)
            return updatedPost
        } catch {
            let alert = AlertModel(title: "Error", message: error.localizedDescription)
            onShowAlert?(alert)
            return nil
        }
    }
    
    @MainActor
    func updatePost(_ post: Post) async {
        self.post = post // Update UI on PostDetail
    }
    
    func deletePost(postId: Int) async -> Bool {
        do {
            // Perform the deletion
            _ = try await postUseCase.deletePost(postId: postId)
            return true
        } catch {
            let alertModel = AlertModel(title: "Error", message: error.localizedDescription)
            onShowAlert?(alertModel)
            return false
        }
    }
    
    @MainActor
    func removePost(post: Post) {
        onDelete?(post) // Callback to PostsList to update ui
    }
    
}
