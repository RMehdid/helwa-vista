//
//  SocialView.swift
//  helwa-vista
//
//  Created by Mehdid, Samy Abderraouf on 06.02.26.
//

import SwiftUI

struct SocialView: View {

    @State private var selectedTab: Tab = .travellers
    
    @StateObject private var vm = ViewModel()
    
    private enum Tab: String, CaseIterable, Identifiable {
        case friends = "Friends"
        case travellers = "Travellers"
        
        var id: String { rawValue }
    }
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(vm.posts) { post in
                    postView(post)
                        .containerRelativeFrame(.vertical)
                        .id(post.id)
                }
            }
            .scrollTargetLayout()
        }
        .scrollPosition(id: $vm.selectedPostId)
        .scrollTargetBehavior(.paging)
        .ignoresSafeArea()
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
            if let currentPost = vm.posts.first(where: { $0.id == vm.selectedPostId }) {
                TravelExperienceView(user: currentPost.user)
                    .glassEffect(.regular.interactive())
                    .padding(.horizontal)
                    .padding(.bottom, 8)
                    .onTapGesture(perform: vm.openUserProfile)
            }
        }
    }
    
    @ViewBuilder
    private func postView(_ post: HVPost) -> some View {
        ZStack {
            HStack {
                Spacer()
                VStack(alignment: .trailing, spacing: 24) {
                    Spacer()
                    
                    Button(action: { vm.likePost(post) }) {
                        Image(systemName: "heart.fill")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundStyle(post.isLiked ? .red : .white)
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
                    
                    Button(action: { vm.bookmarkPost(post) }) {
                        Image(systemName: "bookmark.fill")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundStyle(post.isBookmarked ? .yellow : .white)
                            .scaledToFit()
                            .frame(width: 36, height: 36)
                    }
                    
                    Button(action: vm.sharePost) {
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
            .padding(.trailing, 24)
            .scrollTransition { content, phase in
                content
                    .opacity(1.0 - abs(phase.value))
                    .scaleEffect(1.0 - abs(phase.value) * 0.2)
                    .blur(radius: abs(phase.value) * 5)
            }
        }
        .background(Image(post.imageName)
            .resizable()
            .scaledToFill())
        .contentShape(Rectangle())
    }
}

#Preview {
    SocialView()
}
