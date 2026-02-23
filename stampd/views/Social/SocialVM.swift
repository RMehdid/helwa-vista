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
                let fetchedPosts = try await postManager.fetchMostLikedPosts(limit: 50)
                print(fetchedPosts)
                
                // Fetch users in bulk
                let userIds = fetchedPosts.compactMap { $0.userId }
                let profiles = try await ProfileManager.shared.fetchProfiles(userIds: userIds)
                let profilesDict = Dictionary(uniqueKeysWithValues: profiles.map { ($0.userId, $0) })
                
                // Merge users into HVPost
                let posts = fetchedPosts.map { post -> Post in
                    var post = post
                    if let userId = post.userId {
                        post.user = profilesDict[userId]
                    }
                    return post
                }
                
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
        
        func likePost(_ post: Post) {
            guard case .success(var posts) = postsState else { return }
            
            Task {
                do {
                    let newLikesCount = try await postManager.incrementLikes(postId: post.id)
                    if let index = posts.firstIndex(where: { $0.id == post.id }) {
                        posts[index].isLiked.toggle()
                        posts[index].likesCount = newLikesCount
                    }
                    postsState = .success(posts)
                } catch {
                    postsState = .failure(.custom(message: "Failed to like post"))
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
