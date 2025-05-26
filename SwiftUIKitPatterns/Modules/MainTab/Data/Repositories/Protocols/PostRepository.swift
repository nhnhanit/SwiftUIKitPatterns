//
//  PostRepository.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 22/5/25.
//


protocol PostRepository {
    func getPostsList(start: Int, limit: Int) async throws -> [Post]
    func deletePost(postId: Int) async throws
    func updatePost(postId: Int, isFavorite: Bool) async throws -> Post
    func getPostDetail(postId: Int) async throws -> Post
}
