//
//  ProfileView.swift
//  helwa-vista
//
//  Created by Mehdid, Samy Abderraouf on 10.12.25.
//

import SwiftUI

struct ProfileView: View {
    
    let user: HVUser
    
    var body: some View {
        VStack(spacing: 24){
            VStack(spacing: 16){
                MyPyro(pyro: user.pyro)
                    .frame(width: 70, height: 130)
                    .shadow(radius: 8)
                VStack(alignment: .center){
                    Text(user.lastname)
                        .font(.headline)
                    Text(user.firstname)
                        .font(.largeTitle)
                        .bold()
                }
                Spacer()
            }
            
            HStack {
                labelBuilder(label: "Spots", value: "15")
                labelBuilder(label: "Trips", value: "3")
            }
            
            VStack {
                TripRow(trip: HVTrip.sampleTrip)
                    .frame(height: 120)
                    .shadow(radius: 4, x: 2, y: 4)
            }
            
            VStack(alignment: .leading) {
                Label("Contact the founder", systemImage: "message")
                    .labelStyle(AlignedLabelStyle())
                
                Divider()
                
                Label("Email us", systemImage: "envelope")
                    .labelStyle(AlignedLabelStyle())
                
                Divider()
                
                Label("Join the community", systemImage: "gamecontroller")
                    .labelStyle(AlignedLabelStyle())
                
                Divider()
                
                Label("Leave a review", systemImage: "star")
                    .labelStyle(AlignedLabelStyle())
                
                Divider()
                
                Label("Share our app", systemImage: "square.and.arrow.up")
                    .labelStyle(AlignedLabelStyle())
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .scrollDisabled(true)
            .cornerRadius(16)
            
            Spacer()
        }
        .padding(24)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    Task {
                        try? await AuthManager.shared.signOut()
                    }
                } label: {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                        .foregroundColor(.red)
                }
            }
        }
    }
    
    @ViewBuilder
    func labelBuilder(label: String, value: String) -> some View {
        VStack {
            Text(value)
                .font(.system(size: 24))
            Text(label)
                .font(.system(size: 16))
                .opacity(0.6)
        }
        .frame(width: 72, height: 72)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.primary.opacity(0.6), lineWidth: 2)
        )
    }
}

#Preview {
    ProfileView(user: HVUser.sampleUser)
}

struct AlignedLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.icon
                .frame(width: 24)
            configuration.title
        }
    }
}
