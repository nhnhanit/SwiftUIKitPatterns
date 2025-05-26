//
//  CommentUseCase.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 26/5/25.
//

protocol CommentUseCase {
    func loadCommentsList(postId: Int, start: Int, limit: Int) async throws -> [Comment]
}
