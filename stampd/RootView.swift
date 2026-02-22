//
//  RootView.swift
//  stampd
//
//  Created by Samy Mehdid on 2/22/26.
//

import SwiftUI

struct RootView: View {
    
    @StateObject private var auth = AuthManager.shared
    
    var body: some View {
        
        Group {
            
            switch auth.authState {
                
            case .loading:
                SplashView()
                
            case .authenticated:
                HomeView()
                    .environmentObject(auth)
                
            case .unauthenticated:
                SignInView()
                    .environmentObject(auth)
            }
        }
        .animation(.easeInOut, value: auth.authState)
    }
}

#Preview {
    RootView()
}
