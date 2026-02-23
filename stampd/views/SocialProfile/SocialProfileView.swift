//
//  SocialProfileView.swift
//  stampd
//
//  Created by Mehdid, Samy Abderraouf on 23.02.26.
//
import SwiftUI
internal import Auth

struct SocialProfileView: View {
    
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

            Spacer()
        }
        .padding(24)
    }
}

#Preview {
    SocialProfileView(user: HVUser.sampleUser)
}
