//
//  SignInView.swift
//  helwa-vista
//
//  Created by Mehdid, Samy Abderraouf on 18.02.26.
//

import SwiftUI

struct SignInView: View {
    
    @StateObject private var vm = ViewModel()
    @State private var showSheet = true
    
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
        .sheet(isPresented: $showSheet) {
            SignInSheet
                .presentationDragIndicator(.visible)
                .presentationDetents([.fraction(0.7)])
                .presentationCornerRadius(30)
        }
    }
    
    private var SignInSheet: some View {
        VStack(spacing: 28) {
            
            // MARK: Fields
            
            VStack(spacing: 16) {
                
                TextField("Email", text: $vm.email)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .authFieldStyle()
                
                SecureField("Password", text: $vm.password)
                    .authFieldStyle()
            }
            
            // MARK: Sign In
            
            Button {
                Task { await vm.signIn() }
            } label: {
                if vm.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity)
                        .padding()
                } else {
                    Text("Sign In")
                        .frame(maxWidth: .infinity)
                        .padding()
                }
            }
            .background(Color.black)
            .foregroundColor(.white)
            .cornerRadius(12)
            
            // MARK: Divider
            
            HStack {
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.gray.opacity(0.3))
                
                Text("OR")
                    .foregroundColor(.gray)
                    .font(.footnote)
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.gray.opacity(0.3))
            }
            
            // MARK: Social
            
            VStack(spacing: 12) {
                
                SocialLoginButton(
                    title: "Continue with Google",
                    systemImage: "globe"
                ) {
                    Task { await vm.signInWithGoogle() }
                }
                
                SocialLoginButton(
                    title: "Continue with Google",
                    systemImage: "globe"
                ) {
                    // integrate Google SDK
                }
                
                SocialLoginButton(
                    title: "Continue with Facebook",
                    systemImage: "f.circle"
                ) {
                    // integrate Facebook SDK
                }
            }
            
            // MARK: Sign Up
            
            HStack {
                Text("Don’t have an account?")
                
                Button("Sign Up") {
                    Task { await vm.signUp() }
                }
                .fontWeight(.semibold)
            }
            .font(.footnote)
            
            // MARK: Error
            
            if let error = vm.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .font(.caption)
                    .multilineTextAlignment(.center)
            }
        }
        .padding(24)
    }
}

#Preview {
    SignInView()
}
