//
//  MyPyro.swift
//  helwa-vista
//
//  Created by Mehdid, Samy Abderraouf on 09.12.25.
//

import SwiftUI

struct MyPyro: View {
    let pyro: String
    
    var body: some View {
        Image(pyro)
            .resizable()
            .scaledToFit()
            .padding(1.5)
            .overlay(
                    Rectangle()                       // the stroke “canvas”
                        .stroke(.white, lineWidth: 3)
                        .mask(
                            Image(pyro)
                                .resizable()
                                .scaledToFit()
                        )
                )
            .overlay(
                LinearGradient(colors: [.white.opacity(0.4), .clear],
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                    .mask(
                        Image(pyro)
                            .resizable()
                            .scaledToFit()
                    )
            )
    }
}

#Preview {
    MyPyro(pyro: "10496320")
}
