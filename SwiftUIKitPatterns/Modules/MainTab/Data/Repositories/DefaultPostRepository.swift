//
//  DefaultPostRepository.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 22/5/25.
//

final class DefaultPostRepository: PostRepository {
    
    private let network: NetworkServicing

    init(network: NetworkServicing) {
        self.network = network
    }

    func fetchPostsList(start: Int, limit: Int) async throws -> [Post] {
        let postsList: [Post] = try await network.send(PostAPIRequest.fetchPosts(start: start, limit: limit))
        
        return postsList
    }

    func deletePost(postId: Int) async throws {
        let emptyResponse: EmptyResponse = try await network.send(PostAPIRequest.deletePost(postId: postId))
    }
}
