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
    
    @StateObject private var vm = ViewModel()
    
    private enum Tab: String, CaseIterable, Identifiable {
        case friends = "Friends"
        case travellers = "Travellers"
        
        var id: String { rawValue }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                HStack {
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 24){
                        Spacer()
                        
                        Button(action: vm.likeChallenge) {
                            Image(systemName: "heart.fill")
                                .resizable()
                                .renderingMode(.template)
                                .foregroundStyle(vm.isLiked ? .red : .white)
                                .scaledToFit()
                                .frame(width: 36)
                        }
                        
                        Button(action: vm.openComments) {
                            Image(systemName: "ellipsis.message.fill")
                                .resizable()
                                .renderingMode(.template)
                                .foregroundStyle(.white)
                                .scaledToFit()
                                .frame(width: 36)
                        }
                        
                        Button(action: vm.bookmarkChallenge) {
                            Image(systemName: "bookmark.fill")
                                .resizable()
                                .renderingMode(.template)
                                .foregroundStyle(vm.isBookMarked ? .yellow : .white)
                                .scaledToFit()
                                .frame(width: 36, height: 36)
                        }
                        
                        Button(action: vm.shareChallenge) {
                            Image("send")
                                .resizable()
                                .renderingMode(.template)
                                .foregroundStyle(.white)
                                .scaledToFit()
                                .frame(width: 36, height: 36)
                        }
                        
                        Spacer()
                    }
                    
                }
            }
            .padding(.trailing, 24)
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
                    .onTapGesture(perform: vm.openUserProfile)
            }
            .background(Image("social-example")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea())
            .animation(.spring(response: 0.4, dampingFraction: 0.85), value: selectedTab)
        }
    }
}

#Preview {
    SocialView()
}
