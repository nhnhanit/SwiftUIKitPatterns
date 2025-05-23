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
    @MainActor @Published private(set) var isLoading: Bool = false        // loading lần đầu
    @MainActor @Published private(set) var isLoadMore: Bool = false       // loading thêm
    @MainActor @Published private(set) var isLastPage: Bool = false       // không còn dữ liệu
    @MainActor private(set) var deletingPostIds: Set<Int> = []

    var onShowAlert: ((AlertModel) -> Void)?
    
    private let postUseCase: PostUseCase
    private var currentPage = 0
    private let pageSize = 20
    
    init(postUseCase: PostUseCase) {
        self.postUseCase = postUseCase
    }
    
    func fetchPosts(isLoadMore: Bool = false) {
        Task {
            
            if await self.isLoading { return }
            
            await MainActor.run {
                self.isLoading = true
                self.isLoadMore = isLoadMore
            }
            
            defer {
                Task { @MainActor in
                    self.isLoading = false
                    self.isLoadMore = false
                }
            }

            do {
                let start = currentPage * pageSize
                let newPosts = try await postUseCase.loadPostsList(start: start, limit: pageSize)

                await MainActor.run {
                    if isLoadMore {
                        self.posts.append(contentsOf: newPosts)
                    } else {
                        self.posts = newPosts
                    }

                    if newPosts.count < self.pageSize {
                        self.isLastPage = true
                    } else {
                        self.currentPage += 1
                    }
                }
                
            } catch {
                await MainActor.run {
                    let alertModel = AlertModel(title: "Error", message: error.localizedDescription)
                    onShowAlert?(alertModel)
                }
            }
        }
    }
    
    func loadMoreIfNeeded(currentIndex: Int) {
        Task {
            if await self.isLastPage { return }

            let count = await MainActor.run { self.posts.count }
            guard currentIndex >= count - 5 else { return }
            
            fetchPosts(isLoadMore: true)
        }
    }
    
    func refreshPosts() {
        Task { @MainActor in
            self.isLastPage = false
            self.currentPage = 0
            fetchPosts()
        }
    }
    
    func deletePost(postId: Int) async -> Bool {
        guard await !deletingPostIds.contains(postId) else {
            return false // đang xoá, không xử lý nữa
        }

        await MainActor.run {
            let _ = deletingPostIds.insert(postId)
        }

        defer {
            Task { @MainActor in
                deletingPostIds.remove(postId)
            }
        }

        do {
            let _ = try await postUseCase.deletePost(postId: postId)
            return true
        } catch {
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
}
