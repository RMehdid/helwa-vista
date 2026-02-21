
//
//  HVPost.swift
//  helwa-vista
//
//  Created by Mehdid, Samy Abderraouf on 18.02.26.
//

import Foundation

struct HVPost: Identifiable, Equatable {
    let id = UUID()
    let imageName: String
    let user: HVUser
    var isLiked: Bool = false
    var isBookmarked: Bool = false
    var isReposted: Bool = false
    
    static func == (lhs: HVPost, rhs: HVPost) -> Bool {
        lhs.id == rhs.id
    }
}

extension HVPost {
    static let samplePosts: [HVPost] = [
        HVPost(imageName: "social-example", user: .sampleUser),
        HVPost(imageName: "Budapest", user: .sampleUser),
        HVPost(imageName: "10491791", user: .sampleUser),
        HVPost(imageName: "10491804", user: .sampleUser),
        HVPost(imageName: "10496316", user: .sampleUser)
    ]
}
