//
//  PostRepository.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 22/5/25.
//


protocol PostRepository {
    func fetchPostsList(start: Int, limit: Int) async throws -> [Post]
}
