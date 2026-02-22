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
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .onOpenURL { url in
                    GIDSignIn.sharedInstance.handle(url)
                }
        }
    }
}
