
//
//  TravelExperienceView.swift
//  helwa-vista
//
//  Created by Mehdid, Samy Abderraouf on 06.02.26.
//

import SwiftUI

struct TravelExperienceView: View {
    let user: HVUser
    
    var body: some View {
        HStack(spacing: 8) {
            MyPyro(pyro: user.pyro)
                .scaledToFit()
                .frame(width: 32, height: 32)
            
            Text("\(user.firstname) \(user.lastname)")
                .font(.headline)
                .foregroundStyle(.primary)
            
            Spacer()
            
            Text("+\(user.points) pts")
                .font(.system(.callout, design: .rounded))
                .fontWeight(.bold)
                .padding(6)
                .padding(.horizontal, 8)
                .background(
                    RoundedRectangle(cornerRadius: .infinity)
                        .fill(LinearGradient(
                            colors: [.orange, .pink],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ))
                )
        }
        .padding(8)
    }
}

#Preview {
    ZStack {
        Color.blue.ignoresSafeArea()
        TravelExperienceView(user: HVUser.sampleUser)
            .background {
                RoundedRectangle(cornerRadius: 24)
                    .fill(.ultraThinMaterial)
                    .overlay(
                        RoundedRectangle(cornerRadius: 24)
                            .stroke(.white.opacity(0.5), lineWidth: 1)
                    )
                    .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 4)
            }
            .padding(.horizontal, 24)
    }
}
