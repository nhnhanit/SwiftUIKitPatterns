//
//  PostUseCase.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 22/5/25.
//

protocol PostUseCase {
    func loadPostsList(start: Int, limit: Int) async throws -> [Post]
    func deletePost(postId: Int) async throws
    func updatePost(postId: Int, isFavorite: Bool) async throws -> Post
    func loadPostDetail(postId: Int) async throws -> Post
}
