//
//  ContentView.swift
//  helwa-vista
//
//  Created by Mehdid, Samy Abderraouf on 08.12.25.
//

import MapKit
import SwiftUI

struct HomeView: View {
    
    @StateObject private var vm = ViewModel()

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
                    switch vm.state {
                    case .loading:
                        ProgressView()
                    case .success(let user):
                        NavigationLink(destination: ProfileView(user: user)) {
                                MyPyro(pyro: HVUser.sampleUser.pyro)
                                    .frame(width: 28, height: 38)
                            }
                    case .failure(_):
                        Image(systemName: "person.crop.circle.badge.exclamationmark.fill")
                            .frame(width: 28, height: 38)
                    }
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
                
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: MessagesView()) {
                        Image("send")
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: 24, height: 24)
                        }
                }
            }
            .task {
                await vm.loadProfile()
            }
        }
    }
}

#Preview {
    HomeView()
}
