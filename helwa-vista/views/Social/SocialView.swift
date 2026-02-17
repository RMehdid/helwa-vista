//
//  SocialView.swift
//  helwa-vista
//
//  Created by Mehdid, Samy Abderraouf on 06.02.26.
//

import SwiftUI

struct SocialView: View {
    
    @State private var selectedTab: Tab = .travellers
    
    private enum Tab: String, CaseIterable, Identifiable {
        case friends = "Friends"
        case travellers = "Travellers"
        
        var id: String { rawValue }
    }
    
    var body: some View {
        ZStack {
            VStack {
                Picker("", selection: $selectedTab) {
                    ForEach(Tab.allCases) { tab in
                        Text(tab.rawValue)
                            .tag(tab)
                    }
                }
                .pickerStyle(.segmented)
                .padding(8)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16))
                .frame(width: 300)
                
                Spacer()
                
                TravelExperienceView(user: HVUser.sampleUser)
                    .padding(.horizontal, 24)
            }
        }
        .background(Image("social-example")
            .resizable()
            .scaledToFill()
            .ignoresSafeArea())
        .animation(.spring(response: 0.4, dampingFraction: 0.85), value: selectedTab)
    }
}

#Preview {
    SocialView()
}
