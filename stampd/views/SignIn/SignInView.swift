//
//  SignInView.swift
//  helwa-vista
//
//  Created by Mehdid, Samy Abderraouf on 18.02.26.
//

import SwiftUI

struct SignInView: View {
    
    @State private var selectedDetent: PresentationDetent = .fraction(0.4)
    
    @StateObject private var vm = ViewModel()
    
    var body: some View {
        ZStack(alignment: .top) {
            Image("signin")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack {
                Image("Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80)
                    .padding(.vertical)
                    
                Spacer()
            }
            
        }
        .sheet(isPresented: .constant(true)) {
            SignInSheet()
                .presentationDragIndicator(.visible)
                .presentationDetents([.fraction(0.4), .large], selection: $selectedDetent)
                .presentationCornerRadius(30)
        }
    }
    
    @ViewBuilder
    private func SignInSheet() -> some View {
        VStack(spacing: 24) {
            
            Text("Welcome")
                .font(.title2)
                .bold()
                .padding(.top)
            
            VStack(spacing: 12) {
                Button("Continue with Apple") {}
                    .buttonStyle(.borderedProminent)
                
                Button("Continue with Google") {
                    Task {
                        await vm.signInWithGoogle()
                    }
                }
                    .buttonStyle(.bordered)
                
                Button("Continue with Email") {}
                    .buttonStyle(.bordered)
            }
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    SignInView()
}
