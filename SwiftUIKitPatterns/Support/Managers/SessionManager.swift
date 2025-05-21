//
//  SessionManager.swift
//  SwiftUI_0325
//
//  Created by hongnhan on 18/4/25.
//

import Foundation
import KeychainAccess

final class SessionManager: ObservableObject {
    static let shared = SessionManager()
        
    private let keychain = Keychain(service: "com.yourapp.token")
    private let tokenKey = "accessToken"
    
    private init() {
    }
    
    var accessToken: String? {
        get {
            try? keychain.get(tokenKey)
        }
        set {
            if let token = newValue {
                try? keychain.set(token, key: tokenKey)
            } else {
                try? keychain.remove(tokenKey)
            }
        }
    }
    
    var isLoggedIn: Bool {
        return accessToken != nil
    }
    
    func logIn(with token: String) {
        accessToken = token
    }
    
    func logOut() {
        accessToken = nil
    }
}
