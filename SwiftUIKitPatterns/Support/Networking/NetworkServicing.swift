//
//  NetworkServicing.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 20/5/25.
//


protocol NetworkServicing {
    func send<T: Decodable>(_ request: APIRequest) async throws -> T
}