//
//  DefaultPostUseCase.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 22/5/25.
//


final class DefaultPostUseCase: PostUseCase {
    
    private let repository: PostRepository

    init(repository: PostRepository) {
        self.repository = repository
    }
    
    func loadPostsList(start: Int, limit: Int) async throws -> [Post] {
        return try await repository.fetchPostsList(start: start, limit: limit)
    }
    
    func deletePost(postId: Int) async throws {
        try await repository.deletePost(postId: postId)
    }
}
