//
//  DefaultCommentRepository.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 26/5/25.
//

final class DefaultCommentRepository: CommentRepository {
    
    private let network: NetworkServicing

    init(network: NetworkServicing) {
        self.network = network
    }

    func getCommentsList(postId: Int, start: Int, limit: Int) async throws -> [Comment] {
        let commentsList: [Comment] = try await network.send(PostAPIRequest.getCommentsList(postId: postId, start: start, limit: limit))
        
        return commentsList
    }
    
}
