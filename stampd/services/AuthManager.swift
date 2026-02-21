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
        
    let client = SupabaseClient(
        supabaseURL: URL(string: Bundle.main.object(forInfoDictionaryKey: "supabaseURL") as! String)!,
        supabaseKey: Bundle.main.object(forInfoDictionaryKey: "supabaseKey") as! String
    )
    
    func signInWithMeta(idToken: String) async throws {
        try await client.auth.signInWithIdToken(credentials: .init(provider: .facebook, idToken: idToken))
    }
    
    func googleSignIn() {
        // Find the current window scene.
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
          print("There is no active window scene")
          return
        }

        // Get the root view controller from the window scene.
        guard
          let rootViewController = windowScene.windows.first(where: { $0.isKeyWindow })?
            .rootViewController
        else {
          print("There is no key window or root view controller")
          return
        }

        // Start the sign-in process.
        GIDSignIn.sharedInstance.signIn(
          withPresenting: rootViewController
        ) { signInResult, error in
          guard let result = signInResult else {
            // Inspect error
            print("Error signing in: \(error?.localizedDescription ?? "No error description")")
            return
          }
          // If sign in succeeded, display the app's main content View.
          print("ID Token: \(result.user.idToken?.tokenString ?? "")")
        }
      }
}
