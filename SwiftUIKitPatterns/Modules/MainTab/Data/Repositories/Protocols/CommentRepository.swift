//
//  CommentRepository.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 26/5/25.
//


protocol CommentRepository {
    func getCommentsList(postId: Int, start: Int, limit: Int) async throws -> [Comment]
}
