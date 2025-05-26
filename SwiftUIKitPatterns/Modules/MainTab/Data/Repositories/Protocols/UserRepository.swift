//
//  UserRepository.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 26/5/25.
//

protocol UserRepository {
    func getUserDetail(userId: Int) async throws -> User
}
