//
//  DefaultCommentUseCase.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 26/5/25.
//

final class DefaultCommentUseCase: CommentUseCase {
    
    private let repository: CommentRepository
    
    init(repository: CommentRepository) {
        self.repository = repository
    }
    
    func loadCommentsList(postId: Int, start: Int, limit: Int) async throws -> [Comment] {
        return try await repository.getCommentsList(postId: postId, start: start, limit: limit)
    }
    
}
