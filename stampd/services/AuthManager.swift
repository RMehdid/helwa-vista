//
//  AuthManager.swift
//  stampd
//
//  Created by Mehdid, Samy Abderraouf on 19.02.26.
//

import SwiftUI
import Supabase
import Combine

@MainActor
final class AuthManager: SupabaseManager, ObservableObject {
    
    static let shared = AuthManager()
    
    @Published private(set) var session: Session?
    
    @Published private(set) var authState: AuthState = .loading
    
    var isAuthenticated: Bool {
        session != nil && !(session?.isExpired ?? true)
    }
    
    private override init() {
        super.init()
        
        Task {
            await loadSession()
            listenToAuthChanges()
        }
    }
}

extension AuthManager {
    
    private func loadSession() async {
        session = client.auth.currentSession
    }
    
    private func listenToAuthChanges() {
        Task {
            for await state in client.auth.authStateChanges {
                session = state.session
                
                if let session = state.session, !session.isExpired {
                    authState = .authenticated
                } else {
                    authState = .unauthenticated
                }
            }
        }
    }
}

extension AuthManager {
    
    func signIn(email: String, password: String) async throws {
        try await client.auth.signIn(
            email: email,
            password: password
        )
    }
    
    func signUp(email: String, password: String) async throws {
        let response = try await client.auth.signUp(
            email: email,
            password: password
        )
        
        try await ProfileManager.shared.createProfile(userId: response.user.id, firstname: "User", lastname: "Default")
    }
    
    func signOut() async throws {
        try await client.auth.signOut()
        session = nil
    }
}

extension AuthManager {
    
    func signInWithGoogle(idToken: String) async throws {
        let response = try await client.auth.signInWithIdToken(
            credentials: .init(provider: .google, idToken: idToken)
        )
        
        try await self.handleSocialLogin(user: response.user)
    }
    
    func signInWithApple(idToken: String, nonce: String) async throws {
        let response = try await client.auth.signInWithIdToken(
            credentials: .init(
                provider: .apple,
                idToken: idToken,
                nonce: nonce
            )
        )
        
        try await self.handleSocialLogin(user: response.user)
    }
    
    func signInWithFacebook(accessToken: String) async throws {
        let response = try await client.auth.signInWithIdToken(
            credentials: .init(
                provider: .facebook,
                idToken: accessToken
            )
        )
        
        try await self.handleSocialLogin(user: response.user)
    }
}

extension AuthManager {
    func handleSocialLogin(user: User) async throws {
        
        let firstname = user.userMetadata["full_name"]?.stringValue ?? ""
        
        try await ProfileManager.shared.createProfile(
            userId: user.id,
            firstname: firstname,
            lastname: ""
        )
    }
}
