//
//  AuthManager.swift
//  stampd
//
//  Created by Mehdid, Samy Abderraouf on 19.02.26.
//

import Supabase
import Foundation
import GoogleSignIn

class AuthManager {
    
    static let shared = AuthManager()
        
    var client: SupabaseClient {
        guard
            let host = Bundle.main.object(forInfoDictionaryKey: "supabaseURL") as? String,
            let url = URL(string: "https://\(host)"),
            let key = Bundle.main.object(forInfoDictionaryKey: "supabaseKey") as? String
        else {
            fatalError("Missing or invalid Supabase config in Info.plist")
        }
        
        return SupabaseClient(supabaseURL: url, supabaseKey: key)
    }
    
    func signInWithMeta(idToken: String) async throws {
        try await client.auth.signInWithIdToken(credentials: .init(provider: .facebook, idToken: idToken))
    }
    
    func signInWithGoogle() async throws {
        // Find the current window scene.
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            throw HVError.custom(message: "There is no window scene")
        }
        
        // Get the root view controller from the window scene.
        guard let rootViewController = windowScene.windows.first(where: { $0.isKeyWindow })?.rootViewController else {
            throw HVError.custom(message: "There is no key window or root view controller")
        }
        
        try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)
    }
    
    func signInWithApple(idToken: String) async throws {
        try await client.auth.signInWithIdToken(credentials: .init(provider: .apple, idToken: idToken))
    }
    
    func signInWithEmail(email: String, password: String) async throws {
        try await client.auth.signIn(
          email: email,
          password: password
        )
    }
    
    func signUp(email: String, password: String) async throws {
        try await client.auth.signUp(
          email: email,
          password: password
        )
    }
}

