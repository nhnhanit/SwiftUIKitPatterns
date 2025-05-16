//
//  SessionManager.swift
//  SwiftUI_0325
//
//  Created by hongnhan on 18/4/25.
//

import SwiftUI

final class SessionManager: ObservableObject {
    static let shared = SessionManager()

    @Published private(set) var isLoggedIn: Bool = false
    private(set) var accessToken: String? = nil

    private let tokenKey = "accessToken"

    private init() {
        if let token = UserDefaults.standard.string(forKey: tokenKey) {
            accessToken = token
            isLoggedIn = true
        }
    }

    func logIn(with token: String) {
        accessToken = token
        UserDefaults.standard.set(token, forKey: tokenKey)
        isLoggedIn = true
    }

    func logOut() {
        accessToken = nil
        UserDefaults.standard.removeObject(forKey: tokenKey)
        isLoggedIn = false
    }

    func reset() {
        logOut()
    }
}
