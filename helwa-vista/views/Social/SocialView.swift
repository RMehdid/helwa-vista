//
//  SocialView.swift
//  helwa-vista
//
//  Created by Mehdid, Samy Abderraouf on 06.02.26.
//

import SwiftUI

struct SocialView: View {
    
    @State private var currentUser: HVUser = .sampleUser
    @State private var selectedTab: Tab = .travellers
    
    private enum Tab: String, CaseIterable, Identifiable {
        case friends = "Friends"
        case travellers = "Travellers"
        
        var id: String { rawValue }
    }
    
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                Spacer()
            }
            .safeAreaInset(edge: .top) {
                Picker("", selection: $selectedTab) {
                    ForEach(Tab.allCases) { tab in
                        Text(tab.rawValue)
                            .tag(tab)
                    }
                }
                .pickerStyle(.segmented)
                .glassEffect(.regular.interactive())
                .frame(width: 200)
                .padding(8)
            }
            .safeAreaInset(edge: .bottom) {
                TravelExperienceView(user: currentUser)
                    .glassEffect(.regular.interactive())
                    .padding(.horizontal)
                    .padding(.bottom, 8)
            }
            .background(Image("social-example")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea())
            .animation(.spring(response: 0.4, dampingFraction: 0.85), value: selectedTab)
        }
        .searchable(text: $searchText,
                    placement: .automatic,
                    prompt: "Search users or posts")
    }
}

#Preview {
    ContentView()
}
