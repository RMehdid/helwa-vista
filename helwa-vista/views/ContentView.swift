//
//  ContentView.swift
//  helwa-vista
//
//  Created by Mehdid, Samy Abderraouf on 08.12.25.
//

import MapKit
import SwiftUI

struct ContentView: View {

    var body: some View {
        NavigationStack {
            TabView {
                Tab(HVTabItem.map.title, systemImage: HVTabItem.map.icon) {
                    MapView()
                 }
                Tab(HVTabItem.challenges.title, systemImage: HVTabItem.challenges.icon) {
                    ChallengesView()
                 }
                Tab(HVTabItem.social.title, systemImage: HVTabItem.social.icon) {
                    SocialView()
                 }
                
                Tab(role: .search) {
                    SearchView()
                 }
            }
            .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    MyPyro(pyro: HVUser.sampleUser.pyro)
                        .frame(width: 34, height: 34)
                }
                
                ToolbarItem(placement: .principal) {
                    VStack(spacing: 4) {
                        Text("Berlin")
                            .font(.headline)
                        
                        HStack(spacing: 6) {
                            Image(systemName: "cloud.sun.fill")
                                .foregroundColor(.orange)
                            Text("18°C")
                                .font(.subheadline)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
