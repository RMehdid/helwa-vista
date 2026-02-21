//
//  stampdApp.swift
//  Stampd
//
//  Created by Mehdid, Samy Abderraouf on 08.12.25.
//

import SwiftUI
import GoogleSignIn
import Supabase

@main
struct StampdApp: App {
    let client = AuthManager.shared.client
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                if let user = client.auth.currentUser {
                    HomeView()
                } else {
                    SignInView()
                }
            }
            .onOpenURL { url in
                GIDSignIn.sharedInstance.handle(url)
            }
        }
    }
}
