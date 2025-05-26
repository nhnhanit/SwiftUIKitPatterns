//
//  UserUseCase.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 26/5/25.
//

protocol UserUseCase {
    func loadUserDetail(userId: Int) async throws -> User
}
