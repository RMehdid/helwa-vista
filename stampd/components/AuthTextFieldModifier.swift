//
//  AuthTextFieldModifier.swift
//  stampd
//
//  Created by Samy Mehdid on 2/21/26.
//

import SwiftUI

struct AuthTextFieldModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.systemGray6))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray.opacity(0.2))
            )
    }
}

extension View {
    func authFieldStyle() -> some View {
        modifier(AuthTextFieldModifier())
    }
}
