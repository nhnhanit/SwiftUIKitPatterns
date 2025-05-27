//
//  PostsListViewModel.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 22/5/25.
//

import Combine
import Foundation

final class PostsListViewModel {
    @MainActor @Published private(set) var posts: [Post] = []
    @MainActor @Published private(set) var isLoading: Bool = false        // loading first time
    @MainActor @Published private(set) var isLoadMore: Bool = false       // loading more
    @MainActor @Published private(set) var isLastPage: Bool = false       // latest page
    @MainActor private(set) var deletingPostIds: Set<Int> = []

    var onShowAlert: ((AlertModel) -> Void)?
    
    private let postUseCase: PostUseCase
    private var currentPage = 0
    private let pageSize = 20
    private let navigator: PostNavigator
    
    init(postUseCase: PostUseCase, navigator: PostNavigator) {
        self.postUseCase = postUseCase
        self.navigator = navigator
    }
    
    func fetchPosts(isLoadMore: Bool = false) async {
        
        // Prevent duplicate loading calls
        guard await !isLoading else { return }

        // Mark loading state on main thread
        await MainActor.run {
            isLoading = true
            self.isLoadMore = isLoadMore
        }

        // Ensure loading state resets even if an error occurs
        defer {
            Task { @MainActor in
                isLoading = false
                self.isLoadMore = false
            }
        }

        do {
            // Calculate offset
            let start = currentPage * pageSize
            
            // Load posts from use case
            let newPosts = try await postUseCase.loadPostsList(start: start, limit: pageSize)

            // Update UI and internal state on main thread
            await MainActor.run {
                if isLoadMore {
                    posts.append(contentsOf: newPosts)
                } else {
                    posts = newPosts
                }

                if newPosts.count < pageSize {
                    isLastPage = true
                } else {
                    currentPage += 1
                }
            }
        } catch {
            // Show alert if loading fails
            await MainActor.run {
                let alertModel = AlertModel(title: "Error", message: error.localizedDescription)
                onShowAlert?(alertModel)
            }
        }
    }
    
    func loadMoreIfNeeded(currentIndex: Int) {
        Task {
            // Check isLastPage safely
            guard !(await self.isLastPage) else { return }

            // Get current count on main thread
            let count = await MainActor.run { self.posts.count }

            // Only load more if near the end
            guard currentIndex >= count - 5 else { return }

            await fetchPosts(isLoadMore: true)
        }
    }
    
    func refreshPosts() {
        Task {
            // Reset flags and page on main thread
            await MainActor.run {
                self.isLastPage = false
                self.currentPage = 0
            }

            await fetchPosts()
        }
    }
    
    func deletePost(postId: Int) async -> Bool {
        // Ensure thread-safe access to deletingPostIds on the main actor
        let alreadyDeleting = await MainActor.run {
            return deletingPostIds.contains(postId)
        }
        
        guard !alreadyDeleting else {
            return false // Skip if deletion already in progress
        }

        // Mark post as being deleted
        await MainActor.run {
            _ = deletingPostIds.insert(postId)
        }

        // Ensure cleanup happens regardless of success/failure
        defer {
            Task { @MainActor in
                deletingPostIds.remove(postId)
            }
        }

        do {
            // Perform the deletion
            _ = try await postUseCase.deletePost(postId: postId)
            return true
        } catch {
            // Show alert on main thread if an error occurs
            await MainActor.run {
                let alertModel = AlertModel(title: "Error", message: error.localizedDescription)
                onShowAlert?(alertModel)
            }
            return false
        }
    }
    
    @MainActor
    func removePost(postId: Int) {
        self.posts.removeAll { $0.id == postId }
    }
    
    func updateFavorite(postId: Int, isFavorite: Bool) async -> Post? {
        do {
            let updatedPost = try await postUseCase.updatePost(postId: postId, isFavorite: isFavorite)
            return updatedPost
        } catch {
            await MainActor.run {
                let alert = AlertModel(title: "Error", message: error.localizedDescription)
                onShowAlert?(alert)
            }
            return nil
        }
    }

    @MainActor
    func updatePost(_ post: Post) {
        if let index = posts.firstIndex(where: { $0.id == post.id }) {
            posts[index] = post
        }
    }
    
    func goToPostDetail(postId: Int) {
        navigator.navigateToPostDetail(postId: postId, postsListVM: self)
    }
}
