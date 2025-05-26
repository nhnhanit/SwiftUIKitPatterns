//
//  DefaultUserUseCase.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 26/5/25.
//

final class DefaultUserUseCase: UserUseCase {
    
    private let repository: UserRepository

    init(repository: UserRepository) {
        self.repository = repository
    }
    
    func loadUserDetail(userId: Int) async throws -> User {
        return try await repository.getUserDetail(userId: userId)
    }
}
