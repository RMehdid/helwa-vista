//
//  SignInView.swift
//  helwa-vista
//
//  Created by Mehdid, Samy Abderraouf on 18.02.26.
//

import SwiftUI

struct SignInView: View {
    
    @StateObject private var vm = ViewModel()
    
    @State private var email: String = ""
    @State private var password: String = ""
    
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
                .presentationDetents([.fraction(0.7)])
                .presentationCornerRadius(30)
        }
    }
    
    @ViewBuilder
    private func SignInSheet() -> some View {
        VStack(spacing: 28) {
            
            VStack(spacing: 16) {
                
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .authFieldStyle()
                
                SecureField("Password", text: $password)
                    .authFieldStyle()
            }
            
            Button {
                Task {
                    await vm.signInWithEmail(email: email, password: password)
                }
            } label: {
                Text("Sign In")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            
            HStack {
                Rectangle().frame(height: 1).foregroundColor(.gray.opacity(0.3))
                Text("OR")
                    .foregroundColor(.gray)
                    .font(.footnote)
                Rectangle().frame(height: 1).foregroundColor(.gray.opacity(0.3))
            }
            
            VStack(spacing: 12) {
                
                SocialLoginButton(
                    title: "Continue with Apple",
                    systemImage: "applelogo"
                ) {
                    Task {
                        await vm.signInWithApple(idToken: "hhhh")
                    }
                }
                
                SocialLoginButton(
                    title: "Continue with Google",
                    systemImage: "globe"
                ) {
                    Task {
                        await vm.signInWithGoogle()
                    }
                }
                
                SocialLoginButton(
                    title: "Continue with Facebook",
                    systemImage: "f.circle"
                ) {
                    Task {
                        await vm.signInWithMeta(idToken: "hhhh")
                    }
                }
            }
            
            HStack {
                Text("Don’t have an account?")
                
                Button("Sign Up") {
                    Task {
                        await vm.signUp(email: email, password: password)
                    }
                }
                .fontWeight(.semibold)
            }
            .font(.footnote)
        }
        .padding(24)
    }
}

#Preview {
    SignInView()
}
