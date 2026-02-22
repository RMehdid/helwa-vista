//
//  SplashView.swift
//  stampd
//
//  Created by Samy Mehdid on 2/22/26.
//

import SwiftUI

struct SplashView: View {
    
    @State private var scale: CGFloat = 0.8
    @State private var opacity: Double = 0
    
    private let baseColor = Color(
        red: 176/255,
        green: 76/255,
        blue: 206/255
    )
    
    private let lightColor = Color(
        red: 206/255,
        green: 140/255,
        blue: 230/255
    )
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [lightColor, baseColor],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            // Logo
            Image("Logo")
                .resizable()
                .scaledToFit()
                .frame(width: 120)
                .scaleEffect(scale)
                .opacity(opacity)
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.8)) {
                scale = 1
                opacity = 1
            }
        }
    }
}

#Preview {
    SplashView()
}
