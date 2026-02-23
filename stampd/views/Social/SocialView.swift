//
//  SocialView.swift
//  helwa-vista
//
//  Created by Mehdid, Samy Abderraouf on 06.02.26.
//

import SwiftUI
import AVKit

struct SocialView: View {
    
    @StateObject private var vm = ViewModel()
    
    var body: some View {
        ScrollView {
            switch vm.postsState {
            case .loading:
                ProgressView()
            case .success(let posts):
                LazyVStack(spacing: 0) {
                    ForEach(posts) { post in
                        postView(post)
                            .containerRelativeFrame(.vertical)
                            .id(post.id)
                    }
                }
                .scrollTargetLayout()
            case .failure(let error):
                Text(error.localizedDescription)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .padding()
            }
        }
        .scrollPosition(id: $vm.selectedPostId)
        .scrollTargetBehavior(.paging)
        .ignoresSafeArea()
        .safeAreaInset(edge: .top) {
            Picker("", selection: $vm.selectedTab) {
                ForEach(Tab.allCases) { tab in
                    Text(tab.rawValue).tag(tab)
                }
            }
            .pickerStyle(.segmented)
            .glassEffect(.regular.interactive())
            .frame(width: 200)
            .padding(8)
            .onChange(of: vm.selectedTab, perform: vm.switchTab)
        }
        .safeAreaInset(edge: .bottom) {
            switch vm.postsState {
            case .success(let posts):
                if let currentPost = posts.first(where: { $0.id == vm.selectedPostId }), let user = currentPost.user {
                    NavigationLink(destination: ProfileView(user: user)) {
                        TravelExperienceView(user: user)
                            .glassEffect(.regular.interactive())
                            .padding(.horizontal)
                            .padding(.bottom, 8)
                    }
                }
                
            default:
                EmptyView()
            }
        }
    }

    @ViewBuilder
    private func postView(_ post: Post) -> some View {
        ZStack {
            if let first = post.media.first {
                switch first.type {
                case .image:
                    // Image carousel
                    TabView {
                        ForEach(post.media) { item in
                            if item.type == .image {
                                Image(item.url) // or AsyncImage if URL
                                    .resizable()
                                    .scaledToFill()
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .clipped()
                            }
                        }
                    }
                    .tabViewStyle(.page(indexDisplayMode: .automatic))
                    
                case .video:
                    // Video player
                    if let url = URL(string: first.url) {
                        VideoPlayer(player: AVPlayer(url: url))
                            .onAppear {
                                let player = AVPlayer(url: url)
                                player.isMuted = true
                                player.play()
                                player.actionAtItemEnd = .none
                                NotificationCenter.default.addObserver(
                                    forName: .AVPlayerItemDidPlayToEndTime,
                                    object: player.currentItem,
                                    queue: .main
                                ) { _ in
                                    player.seek(to: .zero)
                                    player.play()
                                }
                            }
                    }
                }
            }
            
            // Overlay buttons
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    VStack(spacing: 24) {
                        Spacer()
                        buttonBuilder(for: "heart.fill", action: { vm.likePost(post) })
                        buttonBuilder(for: "ellipsis.message.fill", action: vm.openComments)
                        buttonBuilder(for: "bookmark.fill", action: { vm.bookmarkPost(post) })
                        buttonBuilder(for: "send", action: vm.sharePost)
                        Spacer()
                    }
                    .padding(.trailing, 24)
                }
            }
        }
        .contentShape(Rectangle())
    }
    
    @ViewBuilder
    func buttonBuilder(for icon: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image(icon)
                .resizable()
                .renderingMode(.template)
                .foregroundStyle(.white)
                .scaledToFit()
                .frame(width: 36, height: 36)
        }
    }
}

#Preview {
    SocialView()
}
