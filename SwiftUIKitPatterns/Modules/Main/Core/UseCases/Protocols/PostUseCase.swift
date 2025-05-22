//
//  PostUseCase.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 22/5/25.
//

protocol PostUseCase {
    func loadPostsList() async throws -> [Post]
}
