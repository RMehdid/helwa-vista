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
        
        @Published private(set) var isLiked: Bool = false
        @Published private(set) var isBookMarked: Bool = false
        @Published private(set) var isReposted: Bool = false
        
        func likeChallenge() -> Void {
            isLiked.toggle()
        }
        
        func openComments() -> Void {
            
        }
        
        func bookmarkChallenge() -> Void {
            isBookMarked.toggle()
        }
        
        func shareChallenge() -> Void {
            
        }
        
        func repostChallenge() -> Void {
            isReposted.toggle()
        }
        
        func openUserProfile() -> Void {
            
        }
    }
}
