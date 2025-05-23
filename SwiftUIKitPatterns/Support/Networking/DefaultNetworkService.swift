//
//  DefaultNetworkService.swift
//  SwiftUI_0325
//
//  Created by hongnhan on 11/4/25.
//

import Foundation

final class DefaultNetworkService: NetworkServicing {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func send<T>(_ request: APIRequest) async throws -> T where T : Decodable {
        var urlComponents = URLComponents(url: request.baseURL.appendingPathComponent(request.path), resolvingAgainstBaseURL: false)
        urlComponents?.queryItems = request.queryItems
        
        guard let url = urlComponents?.url else {
            throw NetworkError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headers
        urlRequest.httpBody = request.body
        
        NetworkLogger.log(request: urlRequest)
        
        do {
            let (data, response) = try await session.data(for: urlRequest)
//            NetworkLogger.log(response: response, data: data)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.unknown(URLError(.badServerResponse))
            }
            
            guard (200..<300).contains(httpResponse.statusCode) else {
                throw NetworkError.serverError(statusCode: httpResponse.statusCode, data: data)
            }
            
            let decoded = try JSONDecoder().decode(T.self, from: data)
            return decoded
            
        } catch let error as DecodingError {
            NetworkLogger.log(error: error)
            throw NetworkError.decodingError(underlying: error)
        } catch let error as URLError {
            NetworkLogger.log(error: error)
            throw NetworkError.urlError(error)
        } catch {
            NetworkLogger.log(error: error)
            throw NetworkError.unknown(error)
        }
        
    }
    
}
