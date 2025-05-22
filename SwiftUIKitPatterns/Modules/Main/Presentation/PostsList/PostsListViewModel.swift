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
    @MainActor @Published private(set) var isLoading: Bool = false
    @MainActor @Published var errorMessage: String?
    
    private let postUseCase: PostUseCase
    
    init(postUseCase: PostUseCase) {
        self.postUseCase = postUseCase
    }
    
    func fetchPosts() {
        Task {
            await MainActor.run { self.isLoading = true }
            
            do {
                let result = try await postUseCase.loadPostsList()
                await MainActor.run {
                    self.posts = result
                    self.isLoading = false
                }
            } catch {
                await MainActor.run {
                    self.errorMessage = error.localizedDescription
                    self.isLoading = false
                }
            }
        }
    }
    
    
}
