//
//  SignInVM.swift
//  helwa-vista
//
//  Created by Mehdid, Samy Abderraouf on 18.02.26.
//

import Combine
import Foundation

extension SignInView {
    @MainActor
    final class ViewModel: ObservableObject {
        
        func signInWithGoogle() async {
            do {
                try await AuthManager.shared.signInWithGoogle()
            } catch {
                print(error.localizedDescription)
            }
        }
        
        func signInWithEmail(email: String, password: String) async {
            do {
                try await AuthManager.shared.signInWithEmail(email: email, password: password)
            } catch {
                print(error.localizedDescription)
            }
        }
        
        func signInWithMeta(idToken: String) async {
            do {
                try await AuthManager.shared.signInWithMeta(idToken: idToken)
            } catch {
                print(error.localizedDescription)
            }
        }
        
        func signInWithApple(idToken: String) async {
            do {
                try await AuthManager.shared.signInWithApple(idToken: idToken)
            } catch {
                print(error.localizedDescription)
            }
        }
        
        func signUp(email: String, password: String) async {
            do {
                try await AuthManager.shared.signUp(email: email, password: password)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
