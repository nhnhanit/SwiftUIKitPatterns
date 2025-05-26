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

    func getPostsList(start: Int, limit: Int) async throws -> [Post] {
        let postsList: [Post] = try await network.send(PostAPIRequest.getPostsList(start: start, limit: limit))
        
        return postsList
    }

    func deletePost(postId: Int) async throws {
        let _: EmptyResponse = try await network.send(PostAPIRequest.deletePost(postId: postId))
    }
    
    func updatePost(postId: Int, isFavorite: Bool) async throws -> Post {
        let updatePostModel: UpdatePostModel = UpdatePostModel(isFavorite: isFavorite)
        let post: Post = try await network.send(PostAPIRequest.updatePost(postId: postId, updatePostModel: updatePostModel))
        
        return post
    }
    
    func getPostDetail(postId: Int) async throws -> Post {
        let postDetail: Post = try await network.send(PostAPIRequest.getPostDetail(postId: postId))
        
        return postDetail
    }
    
}
