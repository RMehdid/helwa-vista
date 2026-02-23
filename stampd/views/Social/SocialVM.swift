//
//  SocialVM.swift
//  helwa-vista
//
//  Created by Mehdid, Samy Abderraouf on 06.02.26.
//

import Foundation
import Combine

extension SocialView {
    enum Tab: String, CaseIterable, Identifiable {
        case friends = "Friends"
        case travellers = "Travellers"
        
        var id: String { rawValue }
    }
    
    @MainActor
    class ViewModel: ObservableObject {
        
        @Published var postsState: UIState<[Post]> = .loading
        @Published var selectedPostId: UUID?
        @Published var selectedTab: Tab = .travellers
        
        private let postManager = PostManager.shared
        
        init() {
            Task { await fetchPosts() }
        }
        
        func fetchPosts() async {
            postsState = .loading
            
            do {
                let posts = try await postManager.fetchMostLikedPosts(limit: 50)
                
                postsState = .success(posts)
                selectedPostId = posts.first?.id
                
            } catch {
                postsState = .failure(.custom(message: error.localizedDescription))
            }
        }
        
        func switchTab(_ tab: Tab) {
            selectedTab = tab
            Task { await fetchPosts() }
        }
        
        // MARK: - Actions
        
        func toggleLike(for post: Post) {
            guard case .success(var posts) = postsState else { return }

            Task {
                do {
                    guard let index = posts.firstIndex(where: { $0.id == post.id }) else { return }

                    let updatedCount: Int

                    if posts[index].isLiked {
                        updatedCount = try await postManager.decrementLikes(postId: post.id)
                    } else {
                        updatedCount = try await postManager.incrementLikes(postId: post.id)
                    }

                    posts[index].isLiked.toggle()
                    posts[index].likesCount = updatedCount
                    postsState = .success(posts)

                } catch {
                    print("Toggle like failed:", error.localizedDescription)
                }
            }
        }
        
        func bookmarkPost(_ post: Post) {
            guard case .success(var posts) = postsState else { return }
            if let index = posts.firstIndex(where: { $0.id == post.id }) {
                posts[index].isBookmarked.toggle()
            }
            postsState = .success(posts)
        }
        
        func repostPost(_ post: Post) {
            guard case .success(var posts) = postsState else { return }
            if let index = posts.firstIndex(where: { $0.id == post.id }) {
                posts[index].isReposted.toggle()
            }
            postsState = .success(posts)
        }
        
        func openComments() {
            
        }
        
        func sharePost() {
            
        }
    }
}
