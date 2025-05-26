//
//  DefaultUserRepository.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 26/5/25.
//

final class DefaultUserRepository: UserRepository {
    
    private let network: NetworkServicing

    init(network: NetworkServicing) {
        self.network = network
    }

    func getUserDetail(userId: Int) async throws -> User {
        let userDetail: User = try await network.send(PostAPIRequest.getUserDetail(userId: userId))
        
        return userDetail
    }

}
