//
//  SignInVM.swift
//  helwa-vista
//
//  Created by Mehdid, Samy Abderraouf on 18.02.26.
//

import Combine
import Foundation
import UIKit
import GoogleSignIn
import FacebookLogin
import FBSDKCoreKit

extension SignInView {
    
    @MainActor
    final class ViewModel: ObservableObject {
        
        @Published var email = ""
        @Published var password = ""
        
        @Published var errorMessage: String?
        @Published var isLoading = false
        
        private let auth = AuthManager.shared
        
        // MARK: - Sign In
        
        func signIn() async {
            guard !email.isEmpty, !password.isEmpty else {
                errorMessage = "Please fill in all fields."
                return
            }
            
            isLoading = true
            errorMessage = nil
            
            defer { isLoading = false }
            
            do {
                try await auth.signIn(email: email, password: password)
            } catch {
                errorMessage = error.localizedDescription
            }
        }
        
        // MARK: - Sign Up
        
        func signUp() async {
            guard !email.isEmpty, !password.isEmpty else {
                errorMessage = "Please fill in all fields."
                return
            }
            
            isLoading = true
            errorMessage = nil
            
            defer { isLoading = false }
            
            do {
                try await auth.signUp(email: email, password: password)
            } catch {
                errorMessage = error.localizedDescription
            }
        }
        
        // MARK: - Sign in with Google
        
        func signInWithGoogle() async {
            do {
                guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                      let rootVC = scene.windows.first?.rootViewController
                else {
                    throw URLError(.badServerResponse)
                }
                
                let result = try await GIDSignIn.sharedInstance.signIn(
                    withPresenting: rootVC
                )
                
                guard let idToken = result.user.idToken?.tokenString else {
                    throw URLError(.badServerResponse)
                }
                
                try await auth.signInWithGoogle(idToken: idToken)
                
            } catch {
                errorMessage = error.localizedDescription
            }
        }
        
        // MARK: - Sign in with Facebook
        
        func signInWithFacebook() async {
            
            guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let rootVC = scene.windows.first?.rootViewController
            else {
                errorMessage = "Unable to get root view controller."
                return
            }
            
            let loginManager = LoginManager()
            
            loginManager.logIn(
                permissions: ["public_profile", "email"],
                from: rootVC
            ) { result, error in
                
                if let error = error {
                    self.errorMessage = error.localizedDescription
                    return
                }
                
                guard
                    let result = result,
                    !result.isCancelled,
                    let tokenString = AccessToken.current?.tokenString
                else {
                    return
                }
                
                Task {
                    do {
                        try await self.auth.signInWithFacebook(accessToken: tokenString)
                    } catch {
                        self.errorMessage = error.localizedDescription
                    }
                }
            }
        }
    }
}
