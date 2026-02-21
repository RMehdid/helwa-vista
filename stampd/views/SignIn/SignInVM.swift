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
    class ViewModel: ObservableObject {
        
        func signInWithGoogle() async {
            do {
                try await AuthManager.shared.googleSignIn()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
