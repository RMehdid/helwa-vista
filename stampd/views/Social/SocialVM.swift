//
//  SocialVM.swift
//  helwa-vista
//
//  Created by Mehdid, Samy Abderraouf on 06.02.26.
//

import Foundation
import Combine

extension SocialView {
    @MainActor
    class ViewModel: ObservableObject {
        
        @Published var posts: [HVPost] = HVPost.samplePosts
        @Published var selectedPostId: UUID?
        
        init() {
            selectedPostId = posts.first?.id
        }
        
        func likePost(_ post: HVPost) {
            if let index = posts.firstIndex(where: { $0.id == post.id }) {
                posts[index].isLiked.toggle()
            }
        }
        
        func bookmarkPost(_ post: HVPost) {
            if let index = posts.firstIndex(where: { $0.id == post.id }) {
                posts[index].isBookmarked.toggle()
            }
        }
        
        func repostPost(_ post: HVPost) {
            if let index = posts.firstIndex(where: { $0.id == post.id }) {
                posts[index].isReposted.toggle()
            }
        }
        
        func openComments() {
            // Implementation for opening comments
        }
        
        func sharePost() {
            // Implementation for sharing
        }
        
        func openUserProfile() {
            // Implementation for opening user profile
        }
    }
}
